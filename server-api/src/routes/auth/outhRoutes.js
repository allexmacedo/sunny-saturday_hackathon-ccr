const Postgres = require('../../db/postgres/base');
const UserSchema = require('../../db/postgres/schemas/userSchema');
const Context = require('../../db/context/contextDatabase');
const Joi = require('@hapi/joi');
const Boom = require('boom');
const bcrypt = require('bcrypt');
const Jwt = require('jsonwebtoken');

async function connection() {
    const connection = await Postgres.connect();
    const model = await Postgres.model(connection, UserSchema);
    return new Context(new Postgres(connection, model));
}

module.exports = [
    {
        method: 'POST',
        path: '/login',
        config: {
            auth: false,
            tags: ['api'],
            validate: {
                failAction: (request, header, err) => {
                    throw err
                },
                payload: Joi.object({
                    usr_email: Joi.string().email().min(10).max(256).required(),
                    usr_password: Joi.string().min(8).max(100).required(),
                })
            },
        },
        handler: async (request, header) => {
            const {usr_email, usr_password} = request.payload;
            const context = await connection();
            let [user] = await context.one({usr_email: usr_email.toLowerCase()});

            if(!user) {
                return Boom.notFound();
            }

            if(!bcrypt.compareSync(usr_password, user.usr_password)) {
                return Boom.unauthorized();
            }

            const token = Jwt.sign({
                email: user.usr_email,
                id: user.usr_id
            }, process.env.JWT_KEY);

            return {'prefix': 'Bearer', 'token': token};
        },

    },
    {
        method: 'GET',
        path: '/version',
        config: {
            auth: false
        },
        handler: async(requeste, header) => {
            return {'version': 'v1.0.0', 'time': new Date()};
        }
    }
]
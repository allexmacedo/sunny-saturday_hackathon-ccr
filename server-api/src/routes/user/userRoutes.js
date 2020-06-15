const Postgres = require('./../../db/postgres/base');
const UserSchema = require('./../../db/postgres/schemas/userSchema');
const Context = require('./../../db/context/contextDatabase');
const Joi = require('@hapi/joi');
const bcrypt = require('bcrypt');
const Jwt = require('jsonwebtoken');

async function connection() {
    const connection = await Postgres.connect();
    const model = await Postgres.model(connection, UserSchema);
    return new Context(new Postgres(connection, model));
}

const headers = Joi.object({
    authorization: Joi.string().required()
}).unknown();

module.exports = [
    {
        method: 'GET',
        path: '/user/{id}',
        config: {
            tags: ['api'],
            validate: {
                failAction: (request, header, err) => {
                    throw err
                },
                params: Joi.object({
                    id: Joi.number().integer()
                }),
                headers
            }
        },
        handler: async (request, header) => {
            const context = await connection();
            const [user] = await context.one({usr_id: request.params.id});

            user.usr_password = null;

            return user;
        }
    },
    {
        method: 'POST',
        path: '/user',
        config: {
            tags: ['api'],
            auth: false,
            validate: {
                failAction: (request, header, err) => {
                    throw err
                },
                payload: Joi.object({
                    user: Joi.object({
                        usr_email: Joi.string().email().min(10).max(256),
                        usr_name: Joi.string().min(3).max(200),
                        usr_password: Joi.string().min(8).max(100),
                        usr_type: Joi.string().valid('driver', 'partner')
                    })
                })
            },
        },
        handler: async (request, header) => {
            const {user} = request.payload;

            const hash = bcrypt.hashSync(user.usr_password, 10);
            user.usr_password = hash;

            const context = await connection();
            const newUser = await context.create(user);

            const token = Jwt.sign({
                email: user.usr_email,
                id: user.usr_id
            }, process.env.JWT_KEY);

            return {'prefix': 'Bearer', 'token': token, 'user': newUser};
        }
    },
    {
        method: 'PUT',
        path: '/user/{id}',
        config: {
            tags: ['api'],
            validate: {
                failAction: (request, header, err) => {
                    throw err
                },
                params: Joi.object({
                    id: Joi.number().integer()
                }),
                headers
            }
        },
        handler: async (request, header) => {
            const context = await connection();
            return await context.update(request.payload.user, request.params.id)
        }
    },
    {
        method: 'DELETE',
        path: '/user/{id}',
        config: {
            tags: ['api'],
            validate: {
                failAction: (request, header, err) => {
                    throw err
                },
                params: Joi.object({
                    id: Joi.number().integer()
                }),
                headers
            }
        },
        handler: async (request, header) => {
            const context = await connection();
            return await context.update(request.params.id)
        }
    }
]
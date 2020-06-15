const Postgres = require('./../../db/postgres/base');
const UserSchema = require('./../../db/postgres/schemas/userSchema');
const PartnerSchema = require('./../../db/postgres/schemas/partnerSchema');
const ScoreSchema = require('../../db/postgres/schemas/scorePartnerSchema');
const Context = require('./../../db/context/contextDatabase');
const Joi = require('@hapi/joi');
const Boom = require('boom');
const Jwt = require('jsonwebtoken');

async function connection(schema) {
    const connection = await Postgres.connect();
    const model = await Postgres.model(connection, schema);
    return new Context(new Postgres(connection, model));
}

const headers = Joi.object({
    authorization: Joi.string().required()
}).unknown();

module.exports = [
    {
        method: 'GET',
        path: '/partner/{id}',
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
            const context = await connection(PartnerSchema);
            const [partner] = await context.one({prt_id: request.params.id});

            return partner;
        }
    },
    {
        method: 'GET',
        path: '/partners',
        config: {
            tags: ['api'],
            auth: false,
        },
        handler: async (request, header) => {
            const context = await connection(PartnerSchema);
            const partners = await context.read();

            return partners;
        }
    },
    {
        method: 'POST',
        path: '/partner',
        config: {
            tags: ['api'],
            validate: {
                failAction: (request, header, err) => {
                    throw err
                },
                headers,
                payload: Joi.object({
                    partner: Joi.object({
                        prt_name: Joi.string().min(5).max(255),
                        prt_description: Joi.string(),
                        prt_type: Joi.number().integer().valid(1, 2),
                        prt_phone: Joi.string(),
                        prt_attendence: Joi.string(),
                        prt_services: Joi.array(),
                        prt_lat: Joi.string(),
                        prt_log: Joi.string(),
                        prt_address: Joi.string(),
                        prt_logo: Joi.string(),
                        prt_image: Joi.string()
                    })
                })
            },
        },
        handler: async (request, header) => {

            const {authorization} = request.headers;
     
            const decode = Jwt.decode(authorization, process.env.JWT_KEY);
        
            let context = await connection(UserSchema);
            const [myUser] = await context.one({usr_id: decode.id});

            if(!myUser) {
                return Boom.notFound();
            }

            let {partner} = request.payload;

            partner.prt_usr_id = decode.id;

            context = await connection(PartnerSchema);
            const myParner = await context.create(partner);

            return myParner;
        }
    },
    {
        method: 'PUT',
        path: '/partner/{id}',
        handler: async (request, header) => {
            const context = await connection();
            return await context.update(request.payload.user, request.params.id)
        }
    },
    {
        method: 'DELETE',
        path: '/partner/{id}',
        handler: async (request, header) => {
            const context = await connection();
            return await context.update(request.params.id)
        }
    }
]
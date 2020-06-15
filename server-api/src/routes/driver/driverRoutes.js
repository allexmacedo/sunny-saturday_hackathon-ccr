const Postgres = require('./../../db/postgres/base');
const UserSchema = require('./../../db/postgres/schemas/driverSchema');
const Context = require('./../../db/context/contextDatabase');
const Joi = require('@hapi/joi');

async function connection() {
    const connection = await Postgres.connect();
    const model = await Postgres.model(connection, UserSchema);
    return new Context(new Postgres(connection, model));
}

module.exports = [
    {
        method: 'GET',
        path: '/driver/{id}',
        config: {
            validate: {
                params: Joi.object({
                    id: Joi.number().integer()
                })
            }
        },
        handler: async (request, header) => {
            const context = await connection();
            return await context.read({prt_id: request.params.id});
        }
    },
    {
        method: 'POST',
        path: '/driver',
        handler: async (request, header) => {
            const context = await connection();
            return await context.create(request.payload.user);
        }
    },
    {
        method: 'PUT',
        path: '/driver/{id}',
        handler: async (request, header) => {
            const context = await connection();
            return await context.update(request.payload.user, request.params.id)
        }
    },
    {
        method: 'DELETE',
        path: '/driver/{id}',
        handler: async (request, header) => {
            const context = await connection();
            return await context.update(request.params.id)
        }
    }
]
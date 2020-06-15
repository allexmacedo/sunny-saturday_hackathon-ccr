const Postgres = require('./../../db/postgres/base');
const CategorieSchema = require('./../../db/postgres/schemas/categorieSchema');
const Context = require('./../../db/context/contextDatabase');
const Joi = require('@hapi/joi');

async function connection(schema) {
    const connection = await Postgres.connect();
    const model = await Postgres.model(connection, schema);
    return new Context(new Postgres(connection, model));
}

module.exports = [
    {
        method: 'GET',
        path: '/categories',
        config: {
            auth: false,
            tags: ['api'],
        },
        handler: async (request, header) => {
            const context = await connection(CategorieSchema);
            const categories = await context.read({});
            return categories;
        }
    },
    {
        method: 'GET',
        path: '/categorie/{id}',
        config: {
            auth: false,
            tags: ['api'],
            validate: {
                failAction: (request, header, err) => {
                    throw err
                },
                params: Joi.object({
                    id: Joi.number().integer()
                }),
            },
        },
        handler: async (request, header) => {
            const context = await connection(CategorieSchema);
            const [categorie] = await context.one({cat_id: request.params.id});
            return categorie
        }
    }
]
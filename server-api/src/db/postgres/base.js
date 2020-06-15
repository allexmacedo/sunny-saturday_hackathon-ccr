const Crud = require('./../interfaces/interfaceCrud');
const Sequelize = require('sequelize');

class Base extends Crud {
    constructor(connection, schema) {
        super();
        this._connection = connection,
        this._schema = schema
    }

    async isConnected() {
        try {   
            await this._connection.authenticate();
            return true;
        } catch(err) {
            console.log('Postgres conection fail: ', err);
            return false;
        }
    }

    async create(item) {
        const { dataValues } = await this._schema.create(item);

        return dataValues;
    }

    async read(item = {}) {
        const result = this._schema.findAll({where: item, raw: true});

        return result;
    }

    async one(item = {}) {
        const result = this._schema.findAll({limit: 1, where: item, row: true});

        return result;
    }

    async update(id, item) {
        const result = await this._schema.update(item, {where: {id: id}});

        return result;
    }

    async delete(id) {
        const query = {id};
        return this._schema.destroy({where: query});
    }

    static async model(connection, schema) {
        const model = connection.define(schema.name, schema.schema, schema.options); 
        await model.sync();
        return model;
    }

    static async connect() {
        const connection = new Sequelize(
            process.env.DBNAME,
            process.env.DBUSER,
            process.env.DBPASSWORD,
            {
                host: process.env.DBHOST,
                dialect: process.env.DBDIALECT,
                quoteIdentifiers: false,
                operatorsAliases: false,
                loggin: true,
                ssl: process.env.SSL,
                dialectOptions: {                   
                    ssl: {
                        require: process.env.SSL,
                        rejectUnauthorized: false
                    }
                }
            }
        ) 

        try {   
            await connection.authenticate();
        } catch(err) {
            console.log('Postgres conection fail: ', err);
            return false;
        }
        
        return connection;
    }
}

module.exports = Base;
const Sequelize = require('sequelize');

const CategorieSchema = {
    name: 'categories',
    schema: {
        cat_id: {
            type: Sequelize.INTEGER,
            required: true,
            primaryKey: true,
            autoIncrement: true
        },
        cat_name: {
            type: Sequelize.TEXT,
            require: true,
            allowNull: false
        },
        cat_description: {
            type: Sequelize.TEXT,
        }
    },

    options: {
        tableName: 'tb_categories',
        freezeTableName: false,
        timestamps: false
    }
}

module.exports = CategorieSchema;
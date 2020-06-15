const Sequelize = require('sequelize');

const UserSchema = {
    name: 'wallets',
    schema: {
        wlt_id: {
            type: Sequelize.INTEGER,
            required: true,
            primaryKey: true,
            autoIncrement: true
        },
        wlt_drv_id: {
            type: Sequelize.INTEGER,
            required: true,
            references: 'tb_drivers',
            referencesKey: 'drv_id'
        },
        wlt_cash: {
            type: Sequelize.NUMBER,
            defaultValue: 0.0
        }
    },

    options: {
        tableName: 'tb_wallet',
        freezeTableName: false
    }
}

module.exports = UserSchema;
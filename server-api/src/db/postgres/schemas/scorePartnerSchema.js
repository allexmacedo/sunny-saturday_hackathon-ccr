const Sequelize = require('sequelize');

const ScorePartnerSchema = {
    name: 'scorePartner',
    schema: {
        scr_id: {
            type: Sequelize.INTEGER,
            required: true,
            primaryKey: true,
            autoIncrement: true
        },
        scr_prt_id: {
            type: Sequelize.INTEGER,
            required: true,
            allowNull: false,
            references: {
                model: 'tb_partners',
                key: 'prt_id'
            }
        },
        scr_value: {
            type: Sequelize.NUMBER,
            defaultValue: 0.0
        },
        scr_range: {
            type: Sequelize.INTEGER,
            defaultValue: 0
        }
    },

    options: {
        tableName: 'tb_scoreParner',
        freezeTableName: false
    }
}

module.exports = ScorePartnerSchema;
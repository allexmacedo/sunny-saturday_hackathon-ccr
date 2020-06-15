const Sequelize = require('sequelize');

const PartnerSchema = {
    name: 'partner',
    schema: {
        prt_id: {
            type: Sequelize.INTEGER,
            required: true,
            primaryKey: true,
            autoIncrement: true
        },
        prt_usr_id: {
            type: Sequelize.INTEGER,
            required: true,
            allowNull: false,
            references: {
                model: 'tb_users',
                key: 'usr_id'
            }
        },
        prt_image: {
            type: Sequelize.STRING,
        },
        prt_logo: {
            type: Sequelize.STRING,
        },
        prt_name: {
            type: Sequelize.STRING,
            require: true,
            allowNull: false
        },
        prt_description: {
            type: Sequelize.TEXT,
            require: true,
            allowNull: false
        },
        prt_type: {
            type: Sequelize.INTEGER,
            require: true
        },
        prt_status: {
            type: Sequelize.BOOLEAN,
            defaultValue: false
        },
        prt_phone: {
            type: Sequelize.STRING,
        },
        prt_address: {
            type: Sequelize.TEXT,
            require: true
        },
        prt_lat: {
            type: Sequelize.TEXT
        },
        prt_log: {
            type: Sequelize.TEXT
        },
        prt_attendence: {
            type: Sequelize.STRING,
        },
        prt_services: {
            type: Sequelize.DataTypes.ARRAY(Sequelize.DataTypes.TEXT),
            require: true,
            allowNull: false
        },
    },

    options: {
        tableName: 'tb_partners',
        freezeTableName: false
    }
}

module.exports = PartnerSchema;
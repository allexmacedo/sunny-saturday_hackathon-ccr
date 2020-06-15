const Sequelize = require('sequelize');

const UserSchema = {
    name: 'users',
    schema: {
        usr_id: {
            type: Sequelize.INTEGER,
            required: true,
            primaryKey: true,
            autoIncrement: true
        },
        usr_name: {
            type: Sequelize.STRING,
        },
        usr_email: {
            type: Sequelize.STRING,
            required: true,
            allowNull: false
        },
        usr_password: {
            type: Sequelize.STRING,
            required: true,
            allowNull: false
        },
        usr_roles: {
            type: Sequelize.DataTypes.ARRAY(Sequelize.DataTypes.TEXT),
            defaultValue: ['user']
        },
        usr_type: {
            type: Sequelize.DataTypes.ENUM('driver', 'partner'),
            required: true,
            allowNull: false
        }
    },

    options: {
        tableName: 'tb_users',
        freezeTableName: false
    }
}

module.exports = UserSchema;
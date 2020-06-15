'use strict';

const {config} = require('dotenv');
const {join} = require('path');
const {ok} = require('assert');

const env = process.env.NODE_ENV || 'local';

ok(env == 'dev' || env == 'local', "invalid env");

const configPath = join(__dirname, './config', `.env.${env}`);

console.log(configPath);

config({
    path: configPath
})

const Hapi = require('@hapi/hapi');
const routes = require('./routes/base/baseRoute');
const HapiSwagger = require('hapi-swagger');
const Vision = require('@hapi/vision');
const Inert = require('@hapi/inert');
const HapiJwt = require('hapi-auth-jwt2');
const HapiCors = require('hapi-cors');

const server = new Hapi.Server({
    port: process.env.PORT,
    routes: {
        cors: {
            origin: ['*'],
            credentials: true
        }
    }
});

async function main() {
    const swaggerOptions = {
        info: {
            title: 'Api Hackathon CCR - Sunny Saturday',
            version: 'v1.0'
        },
        lang: 'pt'
    }

    const Cors = {
        origins: ['*']
    }

    await server.register([
        HapiJwt,
        Vision,
        Inert, 
        {
            plugin: HapiSwagger,
            options: swaggerOptions
        },
        {
            plugin: HapiCors,
            options: Cors
        }
    ])
    
    server.auth.strategy('jwt', 'jwt', {
        key: process.env.JWT_KEY,
        validate: (data, request) => {
            return {
                isValid: true
            }
        }
    });

    server.auth.default('jwt');

    server.route(routes)

    await server.start();
    console.log(`Server running at: ${server.info.port}`)

    return server;
}

module.exports = main();

'use strict';

const AWS = require('aws-sdk');
const config = {
    aws_table_name: 'fruitsTable',
    aws_local_config: {
        region: 'local',
        endpoint: 'http://dynamodb:8000'
    },
    aws_remote_config: {
    }
}; //todo: why cant I import an exported config?


exports.handler = (event, context, callback) => {

            AWS.config.update(config.aws_local_config);

            const docClient = new AWS.DynamoDB.DocumentClient();
            const params = {
                TableName: config.aws_table_name,
            };

            docClient.scan(params, function(err, data) {
                if (err) {
                    console.log(" FLIERP ERROR " + err);
                    callback(null, {body: "Error FLIERP"})
                } else {
                    callback(null, {body: "The data: " + JSON.stringify(data)});
                }
            });

            // callback(null, {body: "hello, this is a " + event.httpMethod + " request"});
};

const {  ONE_SIGNAL_CONFIG   } = require('../config/app.config');

async function sendNotification(data, callback){

    var headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Basic " + ONE_SIGNAL_CONFIG.API_KEY,
    };

    var options = {
        host: "onesignal.com",
        port: 3000,
        path: "/api/v1/notifications",
        method: "POST",
        headers: headers
    };

    console.log(headers);

    var https = require('https');

    var req = https.request(options, function(res){
        res.on('data', function(data){

            console.log(JSON.parse(data));

            return callback(null,JSON.parse(data));
        });
    });

    console.log('Part 2');


    req.on('error', function(e){
        return callback({
            message: e
        });
    });

    req.write(JSON.stringify(data));
    req.end();

    console.log('Part 3');


}

module.exports = {
    sendNotification
}
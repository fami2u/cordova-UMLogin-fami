var exec = require('cordova/exec');

exports.Login = function(arg0, success, error) {
    exec(success, error, "UMLogin", "Login", [arg0]);
};

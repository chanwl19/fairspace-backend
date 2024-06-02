const connectDb = require('../db/connection');

exports.createUser = (req, res) => {
    const user = req.body.user;
    connectDb.createUser(user)
    .then(result => {
        res.status(201).send({errorCode : result.errorCode, errorMsg: result.errorText});
    });
};
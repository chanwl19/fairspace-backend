const connectDb = require('../db/connection');
User = require('../models/user');

exports.login = (req, res) => {
    const userName = req.body.userName;
    const password = req.body.password;
    console.log("I am here")
    connectDb.logIn(userName, password)
    .then(result => {
        const user = new User(userName, password, result.userEmail, result.isAdmin === 1, result.isAuthUser ===1, result.isManagement ===1, result.isItSupport===1);
        res.status(201).send({user: user, errorCode : result.errorCode, errorMsg: result.errorText});
    });
};
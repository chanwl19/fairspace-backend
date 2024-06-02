const connectDb = require('../db/connection');

exports.reserve = (req,res) => {
    const reservation = req.body.reservation;
    const timeFormat = req.body.timeFormat;
    connectDb.reserve(reservation, timeFormat)
    .then(result => {
        res.status(201).send({errorCode : result.errorCode, errorMsg: result.errorText});
    });
};

exports.getReservations = (req,res) => {
    const reservation = req.body.reservation;
    const timeFormat = req.body.timeFormat;
    connectDb.getReservations(reservation, timeFormat)
    .then(result => {
        res.status(200).send({reservations: result.reservations, errorCode : result.errorCode, errorMsg: result.errorText});
    });
};

exports.modifyReservations = (req,res) => {
    const reservation = req.body.reservation;
    const timeFormat = req.body.timeFormat;
    connectDb.modifyReservations(reservation, timeFormat)
    .then(result => {
        res.status(200).send({errorCode : result.errorCode, errorMsg: result.errorText});
    });
};
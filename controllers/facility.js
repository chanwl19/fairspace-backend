const connectDb = require('../db/connection');

exports.addFacility = (req,res) => {
    const facility = req.body.facility;
    connectDb.addFacility(facility)
    .then(result => {
        res.status(201).send({errorCode : result.errorCode, errorMsg: result.errorText});
    });
};

exports.modifyFacility = (req,res) => {
    const facility = req.body.facility;
    connectDb.modifyFacility(facility)
    .then(result => {
        res.status(201).send({errorCode : result.errorCode, errorMsg: result.errorText});
    });
};

exports.deleteFacility = (req,res) => {
    const facility = req.body.facility;
    connectDb.deleteFacility(facility)
    .then(result => {
        res.status(201).send({errorCode : result.errorCode, errorMsg: result.errorText});
    });
};

exports.getFacilities = (req,res) => {
    connectDb.getFacilities()
    .then(result => {
        console.log(result)
        res.status(201).send({facilities: result.facilities, errorCode : result.errorCode, errorMsg: result.errorText});
    });
};
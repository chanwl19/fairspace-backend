const express = require('express');
const router = express.Router();
const facilityController = require('../controllers/facility');

router.post('/add-facility',facilityController.addFacility);

router.post('/modify-facility', facilityController.modifyFacility);

router.post('/delete-facility', facilityController.deleteFacility);

router.get('/get-facilities', facilityController.getFacilities);

module.exports = router;

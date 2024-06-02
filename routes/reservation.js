const express = require('express');
const router = express.Router();
const reservationController = require('../controllers/reservation');

router.post('/reserve',reservationController.reserve);

router.post('/get-reservations',reservationController.getReservations);

router.post('/modify-reservation',reservationController.modifyReservations);

module.exports = router;

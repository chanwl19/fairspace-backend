const express = require('express');
const bodyParser = require('body-parser');

const app = express();

const port = parseInt(process.env.PORT) || process.argv[3] || 3000;

const errorController = require('./controllers/error');

const facilityRoutes = require('./routes/facility');
const loginRoutes = require('./routes/login');
const userRoutes = require('./routes/user');
const reservationRoutes = require('./routes/reservation');

app.use(function (req, res, next) {

   // Website you wish to allow to connect
   res.setHeader('Access-Control-Allow-Origin', '* '); //LINE 5
 
   // Request methods you wish to allow
   res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
 
   // Request headers you wish to allow
   res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,Content-Type,Authorization,Access-Control-Allow-Methods,Access-Control-Request-Headers');
 
   // Set to true if you need the website to include cookies in the requests sent
   res.setHeader('Access-Control-Allow-Credentials', true);
 
   // Pass to next layer of middleware
   next();
});

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use('/login', loginRoutes);
app.use('/facility', facilityRoutes);
app.use('/user',userRoutes);
app.use('/reservation', reservationRoutes);

app.use(errorController.get404);

app.listen(port, () => {
   console.log(`Listening on http://localhost:${port}`);
})
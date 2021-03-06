var express = require('express');
var app = express();
var expressSession = require('express-session');
var cookieParser = require('cookie-parser');
var jwt = require('express-jwt');
var bodyParser = require('body-parser'); //bodyparser + json + urlencoder
var morgan  = require('morgan'); // logger
//var tokenManager = require('./config/token_manager');
//var secret = require('./config/secret');

app.listen(3001);
app.use(cookieParser());
app.use(expressSession({secret:'jasonbournwillbebackagain'}));
app.use(bodyParser());
app.use(morgan());

//Routes
var routes = {};
routes.users = require('./route/users.js');
routes.regions = require('./route/regions.js');
routes.areas = require('./route/areas.js');
routes.territories = require('./route/territories.js');
routes.categories = require('./route/categories.js');
routes.bricks = require('./route/bricks.js');
routes.locations = require('./route/locations.js');


app.all('*', function(req, res, next) {
  res.set('Access-Control-Allow-Origin', 'http://localhost');
  res.set('Access-Control-Allow-Credentials', true);
  res.set('Access-Control-Allow-Methods', 'GET, POST, DELETE, PUT');
  res.set('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Authorization');
  if ('OPTIONS' == req.method) return res.send(200);
  next();
});

//Create a new user
app.post('/signup', routes.users.signup); 

//Login
app.post('/login', routes.users.login); 

app.get('/user', routes.users.getAll);
app.post('/user', routes.users.create);
app.delete('/user/:id', routes.users.delete); 
app.put('/user', routes.users.update);
app.post('/user/authorize', routes.users.authorize);
app.post('/user/restrict', routes.users.restrict);
app.post('/user/makeadmin', routes.users.makeadmin);
app.post('/user/restrictadmin', routes.users.restrictadmin);
app.post('/resetPassword', routes.users.resetPassword);
app.get('/reset_password/:token', routes.users.setupPassword);
app.post('/setup_new_pass', routes.users.setupNewPassword);

app.get('/region', routes.regions.getAll);
app.post('/region', routes.regions.create);
app.delete('/region/:id', routes.regions.delete); 
app.put('/region', routes.regions.update);

////Area///////////////////
app.get('/area', routes.areas.getAll);
app.post('/area', routes.areas.create);
app.delete('/area/:id', routes.areas.delete); 
app.put('/area', routes.areas.update);

////////Territory///////////////
app.get('/territory', routes.territories.getAll);
app.post('/territory', routes.territories.create);
app.delete('/territory/:id', routes.territories.delete); 
app.put('/territory', routes.territories.update); 

////Category//////////////////
app.get('/category', routes.categories.getAll);
app.post('/category', routes.categories.create);
app.delete('/category/:id', routes.categories.delete); 
app.put('/category', routes.categories.update);

app.get('/brick', routes.bricks.getAll);
app.post('/brick', routes.bricks.create);
app.delete('/brick/:id', routes.bricks.delete); 
app.put('/brick', routes.bricks.update);

app.get('/location', routes.locations.getAll);
app.post('/location', routes.locations.create);
app.delete('/location/:id', routes.locations.delete); 
app.put('/location', routes.locations.update);

console.log('Sanofi API is starting on port 3001');
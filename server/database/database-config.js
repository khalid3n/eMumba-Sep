var mongoose = require('mongoose');
var bcrypt = require('bcrypt');
var SALT_WORK_FACTOR = 10;
var mongodbURL = 'mongodb://localhost/sanofi-db';
var mongodbOptions = { };

mongoose.connect(mongodbURL, mongodbOptions, function (err, res) {
    if (err) { 
        console.log('Connection refused to ' + mongodbURL);
        console.log(err);
    } else {
        console.log('Connection successful to: ' + mongodbURL);
    }
});

var Schema = mongoose.Schema;
//////////////////Schema////////////////////////////
// User schema
var User = new Schema({
    password: { type: String },
    is_admin: { type: Boolean,  default: false }, 
    name: { type: String,  required: true }, 
    is_authorized: { type: Boolean, default: false }, 
    designation: { type: String },
    is_email_send: { type: Boolean, default: false},
    email: { type: String, required: true}
});


var Region = new Schema({
    code: { type: String },
    name: { type: String }, 
    created: { type: Date, default: Date.now },
    updated: { type: Date, default: Date.now } 
});


var Area = new Schema({
    code: { type: String },
    name: { type: String },
    created: { type: Date, default: Date.now },
    updated: { type: Date, default: Date.now },
    _region: { type: String, ref: "Region" }
});

var Territory = new Schema({
    code: { type: String },
    name: { type: String },
    created: { type: Date, default: Date.now },
    updated: { type: Date, default: Date.now },
    _area: { type: String, ref: "Area" }
});

var Category = new Schema({
    name: { type: String },
    description: { type: String },
    icon: { type: String },
    created: { type: Date, default: Date.now },
    updated: { type: Date, default: Date.now }
});

var Brick = new Schema({
    name: { type: String },
    color: { type: String},
    created: { type: Date, default: Date.now },
    updated: { type: Date, default: Date.now },
    _territory: { type: String, ref: "Territory"}
});

var Location = new Schema({
    name: { type: String },
    created: { type: Date, default: Date.now },
    updated: { type: Date, default: Date.now },
    _brick: { type: String, ref: "Brick"}
});
//////////////////Schema////////////////////////

///////Encrypt Password////////////////////////
// Bcrypt middleware on UserSchema
User.pre('save', function(next) {
  var user = this;

  if (!user.isModified('password')) return next();

  bcrypt.genSalt(SALT_WORK_FACTOR, function(err, salt) {
    if (err) return next(err);

    bcrypt.hash(user.password, salt, function(err, hash) {
        if (err) return next(err);
        user.password = hash;
        next();
    });
  });
});

//Password verification
User.methods.comparePassword = function(password, cb) {
    bcrypt.compare(password, this.password, function(err, isMatch) {
        if (err) return cb(err);
        cb(isMatch);
    });
};


//Define Models
var userModel = mongoose.model('User', User);
var regionModel = mongoose.model('Region', Region);
var areaModel = mongoose.model('Area', Area);
var territoryModel = mongoose.model('Territory', Territory);
var categoryModel = mongoose.model('Category', Category );
var brickModel = mongoose.model('Brick', Brick);
var locationModel = mongoose.model('Location', Location);


// Export Models
exports.userModel = userModel;
exports.regionModel = regionModel;
exports.areaModel = areaModel;
exports.territoryModel = territoryModel;
exports.categoryModel = categoryModel;
exports.brickModel = brickModel;
exports.locationModel = locationModel;
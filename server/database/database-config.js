var mongoose = require('mongoose');
var bcrypt = require('bcrypt');
var SALT_WORK_FACTOR = 10;
var mongodbURL = 'mongodb://localhost/blog';
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
    email: { type: String, required: true}
});

var Post = new Schema({
    title: { type: String, required: true },
    tags: [ {type: String} ],
    is_published: { type: Boolean, default: false },
    content: { type: String, required: true },
    created: { type: Date, default: Date.now },
    updated: { type: Date, default: Date.now },
    read: { type: Number, default: 0 },
    likes: { type: Number, default: 0 }
});


var Region = new Schema({
    code: { type: String },
    name: { type: String },  
});

var Temp = new Schema({
    code: { type: String},
    name: { type: String}, 
    region: [Region]
});


var Area = new Schema({
    code: { type: String },
    name: { type: String },  
});

var Territory = new Schema({
    code: { type: String },
    name: { type: String },  
});

var Brick = new Schema({
    code: { type: String },
    name: { type: String },  
});


var Location = new Schema({
    code: { type: String },
    name: { type: String },  
});

var Category = new Schema({
    name: { type: String },
    description: { type: String },
    icon: { type: String }
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
var postModel = mongoose.model('Post', Post);
var regionModel = mongoose.model('Region', Region);
var areaModel = mongoose.model('Area', Area);
var territoryModel = mongoose.model('Territory', Territory);
var locationModel = mongoose.model('Location', Location);
var categoryModel = mongoose.model('Category', Category );


// Export Models
exports.userModel = userModel;
exports.postModel = postModel;
exports.regionModel = regionModel;
exports.areaModel = areaModel;
exports.territoryModel = territoryModel;
exports.locationModel = locationModel;
exports.categoryModel = categoryModel;
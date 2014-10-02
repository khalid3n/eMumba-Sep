var db = require('../database/database-config.js');
var jwt = require('jsonwebtoken');
var nodemailer = require('nodemailer');
var async = require('async');
var crypto = require('crypto');

// create reusable transporter object using SMTP transport
var smtpTransport = nodemailer.createTransport({
	service: 'gmail',
	auth: {
	  user: 'khalid.khan@emumba.com',
	  pass: 'et3rc3sa'
	}
});


exports.login = function(req, res) {
	var email = req.body.email || '';
	var password = req.body.password || '';
	if (email == '' || password == '') { 
	 	return res.send(401); 
	}
	console.log(req.body.email + " " + req.body.password);

	db.userModel.findOne({email: email}, function (err, user) {
		if (err) {
			console.log(err);
			return res.send(401);
		}

		if (user == undefined) {
			return res.send(401);
		}
		
		user.comparePassword(password, function(isMatch) {
			if (!isMatch) {
				console.log("Attempt failed to login with " + user.email);
				return res.send(401);
            }

			var token = jwt.sign({id: user._id}, "jhkjhkjhkj", { expiresInMinutes: 60 });
			
			return res.json({token:token});
		});

	});
};

exports.logout = function(req, res) {
	if (req.user) {
		tokenManager.expireToken(req.headers);

		delete req.user;	
		return res.send(200);
	}
	else {
		return res.send(401);
	}
}

exports.signup = function(req, res) {
	var email = req.body.email || '';
	var name = req.body.email || '';
	var password = req.body.password || '';
	var passwordConfirmation = req.body.passwordConfirmation || '';

	if (email == '' || password == '' || password != passwordConfirmation) {
		return res.send(400);
	}

	var user = new db.userModel();
	user.email = email;
	user.password = password;
	user.name = name;

	user.save(function(err) {
		if (err) {
			console.log(err);
			return res.send(500);
		}	
		
		db.userModel.count(function(err, counter) {
			if (err) {
				console.log(err);
				return res.send(500);
			}

			if (counter == 1) {
				db.userModel.update({email:user.email}, function(err, nbRow) {
					if (err) {
						console.log(err);
						return res.send(500);
					}

					console.log('First user created as an Admin');
					return res.send(200);
				});
			} 
			else {
				return res.send(200);
			}
		});
	});
}

exports.getAll = function(req, res) {
	var query = db.userModel.find();
	query.select('name email designation is_admin is_authorized');
	query.exec(function(err, results) {
		if (err) {
  			console.log(err);
  			return res.send(400);
  		}

  		return res.json(200, results);
	});
};

exports.delete = function(req, res) {
  //if (!req.user) {
  //  return res.send(401);
  //}
  var id = req.params.id;
  if (id == null || id == '') {
    res.send(400);
  } 
  var query = db.userModel.findOne({_id:id});

  query.exec(function(err, result) {
    console.log(result);
    if (err) {
      console.log(err);
      return res.send(400);
    }

    if (result != null) {
      result.remove();
      return res.send(200);
    }
    else {
      return res.send(400);
    }
    
  });
};

exports.update = function(req, res) {
  //check if valid user
  //if (!req.user) {
  //  return res.send(401);
  //}

  var user = req.body.user;

  if (user == null || user._id == null) {
    res.send(400);
  }

  var updateUser = {};

  if (user.designation != null && user.designation != "") {
    updateUser.designation = user.designation;
  } 

  if (user.name != null && user.name != "") {
    updateUser.name = user.name;
  } 

  updateUser.is_admin = user.is_admin;
  updateUser.is_authorized = user.is_authorized;

  db.userModel.update({_id: user._id}, updateUser, function(err, nbRows, raw) {
  	if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(200, user);
    //return res.send(200);
  });
};

exports.create = function(req, res) {
  //check for logged in user
  //if (!req.user) {
  //  return res.send(401);
  //}

  var user = req.body.user;
  console.log(user);
  if (user == null || user.designation == null || user.name == null 
  	|| user.email == null) {
    return res.send(400);
  }

  var userModel = new db.userModel();
  userModel.designation = user.designation;
  userModel.name = user.name;
  userModel.email = user.email;

  userModel.save(function(err, user) {
    if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(200, user);
    //return res.send(200);
  });
};

exports.authorize = function(req, res) {
	var id = req.body.id || '';
	if (id == '') {
		return res.send(400);
	}

	db.userModel.update({_id: id}, { is_authorized: true }, function(err, nbRows, raw) {
		if (err) {
			console.log(err);
			return res.send(400);
		}
		var mailOptions = setMailOptions('khalid.khan@emumba.com', req.body.email, 'testsubject', 'some body text');
		transporter.sendMail(mailOptions, function(error, info){
			if (error) {
				console.log(error);
			} else {
				console.log('Message sent: '+ info.response);
			}
		});
		return res.send(200);
	});
}

exports.restrict = function(req, res) {
	var id = req.body.id || '';
	if (id == '') {
		return res.send(400);
	}

	db.userModel.update({_id: id}, { is_authorized: false }, function(err, nbRows, raw) {
		if (err) {
			console.log(err);
			return res.send(400);
		}

		return res.send(200);
	});
}

exports.makeadmin = function(req, res) {
	var id = req.body.id || '';
	if (id == '') {
		return res.send(400);
	}

	db.userModel.update({_id: id}, { is_admin: true }, function(err, nbRows, raw) {
		if (err) {
			console.log(err);
			return res.send(400);
		}

		return res.send(200);
	});
}

exports.restrictadmin = function(req, res) {
	var id = req.body.id || '';
	if (id == '') {
		return res.send(400);
	}

	db.userModel.update({_id: id}, { is_admin: false }, function(err, nbRows, raw) {
		if (err) {
			console.log(err);
			return res.send(400);
		}

		return res.send(200);
	});
}

exports.resetPassword = function(req, res) {
  console.log(11111);
	  // async waterfall will run an array of fucntions in a series
  async.waterfall([
  	// create password reset token
    function(done) {
      crypto.randomBytes(20, function(err, buf) {
        var token = buf.toString('hex');
        done(err, token);
      });
    },

    function(token, done) {
      console.log(req.body.email);
      db.userModel.findOne({ email: req.body.email }, function(err, user) {
        if (!user) {
          // if user doesn't exsit with the provided email
          req.flash('error', 'No account with that email address exists.');
          return res.redirect('http://localhost/dist/index.html#/pages/forgot');
        }

        db.userModel.update({_id: user._id}, { resetPassowordToken: token, 
        	resetPasswordExpiry: Date.now() + (3600000 * 24)}, function(err, nbRows, raw) {
			done(err, token, db.userModel);
		});

      });
    },
    function(token, user, done) {
      
      var mailOptions = {
        to: user.email,
        from: 'khalid.khan@emumba.com',
        subject: 'Sanofi Password Reset',
        text: 'You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\n' +
          'Please click on the following link, or paste this into your browser to complete the process:\n\n' +
          'http://' + req.headers.host + '/reset/' + token + '\n\n' +
          'If you did not request this, please ignore this email and your password will remain unchanged.\n'
      };
      smtpTransport.sendMail(mailOptions, function(err) {
      	console.log(err);
        //req.flash('info', 'An e-mail has been sent to ' + user.email + ' with further instructions.');
        done(err, 'done');
      });
    }
  ], function(err) {
    if (err) {
    	console.log("asdfasdf")
    	//return next(err);
    }
    //res.redirect('/forgot');
    res.send(200);
  });
}
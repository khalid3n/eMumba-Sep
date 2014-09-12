var db = require('../database/database-config.js');
var jwt = require('jsonwebtoken');

exports.login = function(req, res) {
	var email = req.body.email || '';
	var password = req.body.password || '';
	console.log("I am here");
	console.log("here is " + req.body.email + " sdfasd " + req.body.password);
	if (email == '' || password == '') { 
	 	return res.send(401); 
	}
	console.log(req.body.email + " " + req.body.password);

	db.userModel.findOne({email: email}, function (err, user) {
		console.log("user "+ user.email);
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

exports.makeAdmin = function(req, res) {
	var id = req.body.id || '';
	if (id == '') {
		return res.send(400);
	}

	db.userModel.update({_id: id}, { is_authorized: true }, function(err, nbRows, raw) {
		if (err) {
			console.log(err);
			return res.send(400);
		}

		return res.send(200);
	});
}

exports.makeNonAdmin = function(req, res) {
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
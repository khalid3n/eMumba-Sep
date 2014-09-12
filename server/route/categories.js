var db = require('../database/database-config.js');


exports.getAll = function(req, res) {
	var query = db.categoryModel.find();

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
  var query = db.categoryModel.findOne({_id:id});

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

  var category = req.body.category;

  if (category == null || category._id == null) {
    res.send(400);
  }

  var updatecategory = {};

  if (category.description != null && category.description != "") {
    updatecategory.description = category.description;
  } 

  if (category.name != null && category.name != "") {
    updatecategory.name = category.name;
  } 

  db.categoryModel.update({_id: category._id}, updatecategory, function(err, nbRows, raw) {
    return res.json(category);
    //return res.send(200);
  });
};

exports.create = function(req, res) {
  //check for logged in user
  //if (!req.user) {
  //  return res.send(401);
  //}

  var category = req.body.category;
  if (category == null || category.description == null || category.name == null) {
    return res.send(400);
  }

  var categoryModel = new db.categoryModel();
  categoryModel.description = category.description;
  categoryModel.name = category.name;

  categoryModel.save(function(err, category) {
    if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(category);
    //return res.send(200);
  });
};
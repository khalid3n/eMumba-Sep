var db = require('../database/database-config.js');


exports.getAll = function(req, res) {
	var query = db.regionModel.find();
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
  var query = db.regionModel.findOne({_id:id});

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

  var region = req.body.region;

  if (region == null || region._id == null) {
    res.send(400);
  }

  var updateRegion = {};

  if (region.code != null && region.code != "") {
    updateRegion.code = region.code;
  } 

  if (region.name != null && region.name != "") {
    updateRegion.name = region.name;
  } 

  db.regionModel.update({_id: region._id}, updateRegion, function(err, nbRows, raw) {
    if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(200, region);
    //return res.send(200);
  });
};

exports.create = function(req, res) {
  //check for logged in user
  //if (!req.user) {
  //  return res.send(401);
  //}

  var region = req.body.region;
  if (region == null || region.code == null || region.name == null) {
    return res.send(400);
  }

  var regionModel = new db.regionModel();
  regionModel.code = region.code;
  regionModel.name = region.name;

  regionModel.save(function(err, region) {
    if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(200, region);
    //return res.send(200);
  });
};
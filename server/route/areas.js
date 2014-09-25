var db = require('../database/database-config.js');


exports.getAll = function(req, res) {
	var query = db.areaModel.find();
  query.populate('_region')
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
  var query = db.areaModel.findOne({_id:id});

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

  var area = req.body.area;

  if (area == null || area._id == null) {
    res.send(400);
  }

  var updateArea = {};

  if (area.code != null && area.code != "") {
    updateArea.code = area.code;
  } 

  if (area.name != null && area.name != "") {
    updateArea.name = area.name;
  } 

  db.areaModel.update({_id: area._id}, updateArea, function(err, nbRows, raw) {
    return res.json(200, area);
    //return res.send(200);
  });
};

exports.create = function(req, res) {
  //check for logged in user
  //if (!req.user) {
  //  return res.send(401);
  //}

  var area = req.body.area;
  if (area == null || area.code == null || area.name == null) {
    return res.send(400);
  }

  var areaModel = new db.areaModel();
  areaModel.code = area.code;
  areaModel.name = area.name;
  areaModel._region = area._ref._id;

  areaModel.save(function(err, area) {
    if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(200, area);
    //return res.send(200);
  });
};
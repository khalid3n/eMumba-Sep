var db = require('../database/database-config.js');


exports.getAll = function(req, res) {
  var location = db.locationModel;
  location.find()
  .lean()
  .populate({ path: '_brick' })
  .populate({ path: '_category' })
  .exec(function(err, docs) {

    var options = {
      path: '_brick._territory',
      model: 'Territory'
    };

    if (err) return res.json(500);
    location.populate(docs, {path: '_brick._territory', model: 'Territory'}, function (err, docs) {
      location.populate(docs, {path: '_brick._territory._area', model: 'Area'}, function(err, docs){
        location.populate(docs, {path: '_brick._territory._area._region', model: 'Region'}, function(err, results){
          res.json(results);
        });
      });
    });
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
  var query = db.locationModel.findOne({_id:id});

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

  var location = req.body.location;

  if (location == null || location._id == null) {
    res.send(400);
  }

  var updatelocation = {};

  if (location.name != null && location.name != "") {
    updatelocation.name = location.name;
  } 
  updatelocation._brick = location._ref._id;
  updatelocation._category = location._category_ref._id;
  updatelocation.loc = location.loc;
  
  db.locationModel.update({_id: location._id}, updatelocation, function(err, nbRows, raw) {
    //return res.send(200);
    return res.json(200, location);
  });
};

exports.create = function(req, res) {
  //check for logged in user
  //if (!req.user) {
  //  return res.send(401);
  //}

  var location = req.body.location;
  console.log(location._ref._id)
  if (location == null || location.name == null) {
    return res.send(400);
  }

  var locationModel = new db.locationModel();
  locationModel.name = location.name;
  locationModel.loc = location.loc;
  locationModel._brick = location._ref._id;
  locationModel._category = location._category_ref._id;
  location._brick = location._ref; 
  location._ref = null;
  location._category = location._category_ref;
  location._category_ref = null;

  locationModel.save(function(err) {
    if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(200, location);
    //return res.send(200);
  });
};
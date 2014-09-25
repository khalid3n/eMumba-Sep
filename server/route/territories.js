var db = require('../database/database-config.js');


exports.getAll = function(req, res) {
  var Territory = db.territoryModel;
  Territory.find()
  .lean()
  .populate({ path: '_area' })
  .exec(function(err, docs) {

    var options = {
      path: '_area._region',
      model: 'Region'
    };

    if (err) return res.json(500);
    Territory.populate(docs, options, function (err, territories) {
      res.json(territories);
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
  var query = db.territoryModel.findOne({_id:id});

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

  var territory = req.body.territory;

  if (territory == null || territory._id == null) {
    res.send(400);
  }

  var updateTerritory = {};

  if (territory.code != null && territory.code != "") {
    updateTerritory.code = territory.code;
  } 

  if (territory.name != null && territory.name != "") {
    updateTerritory.name = territory.name;
  } 

  db.territoryModel.update({_id: territory._id}, updateTerritory, function(err, nbRows, raw) {
    //return res.send(200);
    return res.json(200, territory);
  });
};

exports.create = function(req, res) {
  //check for logged in user
  //if (!req.user) {
  //  return res.send(401);
  //}

  var territory = req.body.territory;
  if (territory == null || territory.code == null || territory.name == null) {
    return res.send(400);
  }

  var territoryModel = new db.territoryModel();
  territoryModel.code = territory.code;
  territoryModel.name = territory.name;
  territoryModel._area = territory._ref._id

  territoryModel.save(function(err, territory) {
    if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(200, territory);
    //return res.send(200);
  });
};
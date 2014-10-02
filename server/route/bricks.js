var db = require('../database/database-config.js');


exports.getAll = function(req, res) {
  var brick = db.brickModel;
  brick.find()
  .lean()
  .populate({ path: '_territory' })
  .exec(function(err, docs) {

    if (err) return res.json(500);
    brick.populate(docs, {path: '_territory._area', model: 'Area'}, function (err, bricks) {
      brick.populate(bricks, {path: '_territory._area._region', model: 'Region'}, function(err, results){
          res.json(results);
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
  var query = db.brickModel.findOne({_id:id});

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

  var brick = req.body.brick;

  if (brick == null || brick._id == null) {
    res.send(400);
  }

  var updatebrick = {};

  if (brick.name != null && brick.name != "") {
    updatebrick.name = brick.name;
  } 
  brickModel._territory = brick._ref._id;

  db.brickModel.update({_id: brick._id}, updatebrick, function(err, nbRows, raw) {
    //return res.send(200);
    return res.json(200, brick);
  });
};

exports.create = function(req, res) {
  //check for logged in user
  //if (!req.user) {
  //  return res.send(401);
  //}

  var brick = req.body.brick;
  if (brick == null || brick.name == null) {
    return res.send(400);
  }

  var brickModel = new db.brickModel();
  brickModel.name = brick.name;
  brickModel._territory = brick._ref._id;

  brickModel.save(function(err, brick) {
    if (err) {
      console.log(err);
      return res.send(400);
    }
    return res.json(200, brick);
    //return res.send(200);
  });
};
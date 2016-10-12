'use strict';

let express = require('express'),
    router = express.Router();

router.use('/create', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/details', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/listPosts', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/listThreads', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/listUsers', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);

module.exports = router;

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
router.use('/list', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/remove', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/restore', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/update', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/vote', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);

module.exports = router;

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
router.use('/follow', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/listFollowers', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/listFollowing', function (req, res){
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
router.use('/unfollow', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);
router.use('/updateProfile', function (req, res){
    //ok handler
  }, function(req, res) {
    //bad handler
  }
);

module.exports = router;

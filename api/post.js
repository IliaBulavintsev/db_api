"use strict";
const express = require('express');
const router = express.Router();
const db = require('../db');
const response = require('../response');
const Post = require('../models/post').Post;
const PostManager = require('../managers/post_manager').PostManager;
const utils = require('../utils');

var update_post = function(options,req,res){
    let post = new Post();
    post.id = req.body.post;
    post[options.method](function(result){
        if(options.extended_response)
            res.json(response.ok(post));
        else
            res.json(response.ok(req.body));
    },function(err){
        req.next(err);
    }, req.body);
};

router.use('/create',function(req,res){
    var post = new Post();
    post.copy(req.body);
    post.isApproved = req.body.isApproved;
    post.isDeleted = req.body.isDeleted;
    post.isEdited = req.body.isEdited ;
    post.isHighlighted= req.body.isHighlighted;
    post.isSpam = req.body.isSpam;
    post.save(function(result){
        res.json(response.ok(post));
    },function(err){
        if(err.errno === db.DB_ERRORS.DUPLICATE){
            post.id = err.insertId;
            res.json(response.ok(thread));
        }else {
            req.next(err);
        }
    });
});
router.use('/details',function(req,res){
    let post = new Post();
    post.id = req.query.post;
    let related = utils.related_set(req.query.related);
    post.fetch(function(result){
        res.json(response.ok(post));
    },function(err){
        req.next(err);
    },{'related':related});
});
router.use('/list',function(req,res){
    req.query.related = utils.related_set(req.query.related);
    PostManager.list(
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
        },req.query);
});
router.use('/remove',function(req,res){
    update_post({method:'remove'},req,res);
});
router.use('/restore',function(req,res){
    update_post({method:'restore'},req,res);
});
router.use('/update',function(req,res){
    update_post({method:'update',extended_response:true},req,res);
});
router.use('/vote',function(req,res){
    update_post({method:'vote',extended_response:true},req,res);
});

module.exports=router;

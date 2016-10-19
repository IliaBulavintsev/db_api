/**
 * Created by danil on 21.03.16.
 */
"use strict";
const express = require('express');
const router = express.Router();
const db = require('../db');
const utils =  require('../utils');
const response = require('../response');
const Forum = require ('../models/forum').Forum;
const ForumManager = require('../managers/forum_manager').ForumManager;
const TABLE_NAME ='Forums';

router.use('/create',function(req,res){
    var forum = new Forum();
    forum.copy(req.body);
    forum.save(function(result){
        "use strict";
        res.json(response.ok(forum));
    },function(err){
        "use strict";
        if(err.errno === db.DB_ERRORS.DUPLICATE){
            forum.id = err.insertId;
            res.json(response.ok(forum));
        }else {
            req.next(err);
        }
    });
});
router.get('/details',function(req,res){
    let forum = new Forum();
    let err = utils.check_related(req.query.related,"Forums");
    if (err){
        req.next(err);
    }
    req.query.related = utils.related_set(req.query.related);
    forum.short_name = req.query.forum;
    forum.fetch(function(result){
        res.json(response.ok(forum));
    },function(err){
        req.next(err);
    },req.query);
});
router.use('/listPosts',function(req,res){
    let err = utils.check_related(req.query.related,"Posts");
    if (err){
        req.next(err);
    }
    req.query.related = utils.related_set(req.query.related);
    ForumManager.list_posts(
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
        },req.query);
});
router.use('/listThreads',function(req,res){
    let err = utils.check_related(req.query.related,"Threads");
    if (err){
        req.next(err);
    }
    req.query.related = utils.related_set(req.query.related);
    ForumManager.list_threads(
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
    },req.query);
});
router.use('/listUsers',function(req,res){
    ForumManager.list_users(
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
    },req.query);
});
module.exports=router;
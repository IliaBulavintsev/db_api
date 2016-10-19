/**
 * Created by danil on 21.03.16.
 */
"use strict";
const express = require('express');
const router = express.Router();
const User = require('../models/user').User;
const UserManager = require('../managers/user_manager').UserManager;
const FollowingManager = require('../managers/following_manager').FollowingManager;
const db = require('../db');
const utils = require('../utils');
const response = require('../response');
const TABLE_NAME = 'Users';

var follow_handle = function(action, req, res){
    let user = new User();
    user.email = req.body.follower;
    FollowingManager[action](req.body.follower,req.body.followee,function(result){
        user.fetch(function(result){
            res.json(response.ok(user));
        },function(err){
            req.next(err);
        })
    },function(err){
        req.next(err);
    });
};

router.use('/create',function(req,res){

    let user = new User();
    user.copy(req.body);
    user.save(function(result){
        res.json(response.ok(user));
    },
    function(err){
        if(err.errno === db.DB_ERRORS.DUPLICATE) {
            err.message = 'User with email ' + user.email + ' is already exist';
            err.type ='user_already_exists';
        }
        req.next(err);
    });

});

router.use('/details',function(req,res){
    let user = new User();
    user.email = req.query.user;
    user.fetch(function(result){
        res.json(response.ok(user));
    },function(err){
        req.next(err);
    });
});
router.use('/follow',function(req,res){
    follow_handle('follow',req,res);
});
router.use('/listFollowers',function(req,res){
    FollowingManager.list_followers(req.query,
                     function(result){
                         res.json(response.ok(result))
                     },
                     function(err){
                         req.next(err);
                     });
});
router.use('/listFollowing',function(req,res){
    FollowingManager.list_following(req.query,
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
        })
});
router.use('/listPosts',function(req,res){
    req.query.related = utils.related_set(req.query.related);
    UserManager.list_posts(
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
        },req.query);
});
router.use('/unfollow',function(req,res){
    follow_handle('unfollow',req,res);
});
router.use('/updateProfile',function(req,res){
    let user = new User();
    user.copy(req.body);
    user.email = req.body.user;
    user.update(function(result){
        res.json(response.ok(user));
    },function(err){
        req.next(err);
    });
});

module.exports=router;
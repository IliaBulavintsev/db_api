"use strict";
const express = require('express');
const router = express.Router();
const Thread = require('../models/thread').Thread;
const User = require('../models/user').User;
const SubscriptionManager=require('../managers/subscription_manager').SubscriptionManager;
const db = require('../db');
const utils = require('../utils');
const response = require('../response');
const ThreadManager = require('../managers/thread_manager').ThreadManager;

var subscribe_handle = function(action, req, res){
    SubscriptionManager[action](req.body.user,req.body.thread,function(result){
        res.json(response.ok(req.body));
    },function(err){
        req.next(err);
    });
};
var update_thread = function(options,req,res){
    let thread = new Thread();
    thread.id = req.body.thread;
    thread[options.method](function(result){
        if(options.extended_response)
            res.json(response.ok(thread));
        else
            res.json(response.ok(req.body));
    },function(err){
        req.next(err);
    }, req.body);
};

router.use('/create',function(req,res){
    var thread = new Thread();
    thread.copy(req.body);
    thread.isClosed = req.body.isClosed;
    thread.isDeleted = req.body.isDeleted;
    thread.save(function(result){
        "use strict";
        res.json(response.ok(thread));
    },function(err){
        "use strict";
        if(err.errno === db.DB_ERRORS.DUPLICATE){
            thread.id = err.insertId;
            res.json(response.ok(thread));
        }else {
            req.next(err);
        }
    });
});
router.use('/details',function(req,res){
    let thread = new Thread();
    thread.id = req.query.thread;

    let related = utils.related_set(req.query.related);
    thread.fetch(function(result){
        res.json(response.ok(thread));
    },function(err){
        req.next(err);
    },{'related':related});
});
router.use('/list',function(req,res){
    req.query.related = utils.related_set(req.query.related);
    ThreadManager.list(
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
        },req.query);
});
router.use('/listPosts',function(req,res){
    req.query.related = utils.related_set(req.query.related);
    ThreadManager.list_posts(
        function(result){
            res.json(response.ok(result))
        },
        function(err){
            req.next(err);
        },req.query);
});
router.use('/remove',function(req,res){
    update_thread({method:'remove'},req,res);
});
router.use('/restore',function(req,res){
    update_thread({method:'restore'},req,res);
});
router.use('/update',function(req,res){
    update_thread({method:'update',extended_response:true},req,res);
});
router.use('/vote',function(req,res){
    update_thread({method:'vote',extended_response:true},req,res);

});
router.use('/close',function(req,res){
    update_thread({method:'close'},req,res);
});
router.use('/open',function(req,res){
    update_thread({method:'open'},req,res);
});
router.use('/subscribe',function(req,res){
    subscribe_handle('subscribe',req,res);
});
router.use('/unsubscribe',function(req,res){
    subscribe_handle('unsubscribe',req,res);
});

module.exports=router;

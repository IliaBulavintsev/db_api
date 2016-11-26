//const Forum = require('models/forum').Forum;

"use strict";
const Post = require('../models/post').Post;
const Thread = require('../models/thread').Thread;
const User = require('../models/user').User;
const db = require('../db');
const utils = require('../utils');

const  USERLIST_OPTIONS ={
    'class':User,
    'order_field':'name',
    'pk_res':'user',
    'table':'Users as U INNER JOIN Posts as P on P.user = U.email',
    'columns':'user',
    'primary_key':'email'
};
const  THREADIST_OPTIONS ={
    'class':Thread,
    'order_field':'date',
    'pk_res':'id',
    'table':'Threads',
    'columns':'id',
    'primary_key':'id'
};
const  POSTLIST_OPTIONS ={
    'class':Post,
    'order_field':'date',
    'pk_res':'id',
    'table':'Posts',
    'columns':'id',
    'primary_key':'id'
};

class ForumManager {
    static list_users(success,error,options){
        let getlist_options = USERLIST_OPTIONS;
        getlist_options.equals = db.format('forum =? ',[options.forum]);
        getlist_options.since = 'U.id >= ' + (options.since_id?options.since_id:'0');
        getlist_options.limit = options.limit;
        getlist_options.order = options.order;
        utils.get_list(success,error,getlist_options);
    }
    static list_threads(success,error,options) {
        let getlist_options = THREADIST_OPTIONS;
        getlist_options.equals = db.format('forum = ? ',[options.forum]);
        getlist_options.since = db.format('date >= ?', (options.since?options.since:'1000-01-01'));
        getlist_options.limit = options.limit;
        getlist_options.order = options.order;
        getlist_options.fetch_options ={related:options.related};
        utils.get_list(success,error,getlist_options);
    }
    static list_posts(success,error,options) {
        let getlist_options = POSTLIST_OPTIONS;
        getlist_options.equals = db.format('forum = ? ',[options.forum]);
        getlist_options.since = db.format('date >= ?', (options.since?options.since:'1000-01-01'));
        getlist_options.limit = options.limit;
        getlist_options.order = options.order;
        getlist_options.fetch_options ={related:options.related};
        utils.get_list(success,error,getlist_options);
    }
}
exports.ForumManager = ForumManager;

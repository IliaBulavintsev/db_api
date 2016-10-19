/**
 * Created by danil on 24.04.16.
 */
"use strict";
const Post = require('../models/post').Post;
const Thread = require('../models/thread').Thread;
const User = require('../models/user').User;
const db = require('../db');
const utils = require('../utils');



const  POSTLIST_OPTIONS ={
    'class':Post,
    'order_field':'date',
    'pk_res':'id',
    'table':'Posts',
    'columns':'id',
    'primary_key':'id'
};

class PostManager {
    static list(success,error,options) {
        let getlist_options = POSTLIST_OPTIONS;
        getlist_options.equals = options.thread ? db.format('thread=?',options.thread): db.format('forum=?',options.forum);
        getlist_options.since = db.format('date >= ?', (options.since?options.since:'1000-01-01'));
        getlist_options.limit = options.limit;
        getlist_options.order = options.order;
        getlist_options.fetch_options ={related:options.related};
        utils.get_list(success,error,getlist_options);
    }
}
exports.PostManager = PostManager;
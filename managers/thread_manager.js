/**
 * Created by danil on 24.04.16.
 */
"use strict";
const Post = require('../models/post').Post;
const Thread = require('../models/thread').Thread;
const User = require('../models/user').User;
const db = require('../db');
const utils = require('../utils');



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
    'pk_res':'id',
    'table':'Posts',
    'columns':'id',
    'primary_key':'id'
};
const parent_tree_list = function(success,error, options){
    //(IN _thread INT,
    //IN _since TIMESTAMP,
    //IN _order VARCHAR (4),
    //IN _limit INT)
    let sql = 'CALL parent_tree_post_list(?,?,?,?)';
    sql = db.format(sql,[options.thread,
                        (options.since)?options.since:'1000-01-01',
                        (options.order === 'asc')?'asc':'desc',
                        (options.limit)?options.limit:(1<<31)]);
    db.query(sql).then(function(result){
        console.log(result);
        let posts = new Array(result[0].length);
        for(let i =0 ; i< result[0].length; i++){
            posts[i] = new Post();
            posts[i].id = result[0][i].id;
        }
        utils.array_fetch(posts,success,error,{});
    }).catch(function(err){
        error(err);
    });

};

class ThreadManager {
    static list(success,error,options) {
        let getlist_options = THREADIST_OPTIONS;
        getlist_options.equals = options.user ? db.format('user= ?',options.user): db.format('forum= ?',options.forum);
        getlist_options.since = db.format('date >= ?', (options.since?options.since:'1000-01-01'));
        getlist_options.limit = options.limit;
        getlist_options.order = options.order;
        getlist_options.fetch_options ={related:options.related};
        utils.get_list(success,error,getlist_options);
    }
    static list_posts(success,error,options) {
        if(options['sort'] !== 'parent_tree' || !options.limit) {
            let getlist_options = POSTLIST_OPTIONS;
            getlist_options.equals = db.format('thread= ? ', [options.thread]);
            getlist_options.since = db.format('date >= ?', (options.since ? options.since : '1000-01-01'));

            if (options['sort'] === 'tree' ) {
                getlist_options.explicit_order = (options.order === 'asc') ? 'path' : 'root DESC, path ASC';
            }
            else {
                getlist_options.explicit_order = null;
                getlist_options.order_field = 'date';
            }
            getlist_options.limit = options.limit;
            getlist_options.order = options.order;
            getlist_options.fetch_options = {related: options.related};
            console.log(getlist_options);
            utils.get_list(success, error, getlist_options);
        }
        else{
            parent_tree_list(success,error,options);
        }
    }
}
exports.ThreadManager = ThreadManager;
/**
 * Created by danil on 08.04.16.
 */
"use strict";
const db =require('../db');
const utils =require('../utils');
const EventEmitter = require('events');
const User = require('../models/user').User;

const LIST_OPTIONS_TEMPLATE = {

    'class':User,
    'order_field':'id',
    'primary_key':'email',
    //'pk_res':'email'
};

var follow_list = function (type ,options, success, error){
    let subject = 'followee';//type === 'followers'
    let objects = 'follower';//type === 'followers'
    if(type === 'following'){
        subject = 'follower';
        objects = 'followee';
    }
    let getlist_options = LIST_OPTIONS_TEMPLATE;
    getlist_options.table= 'Followings as F inner join Users as U on U.email=F.' + objects;
    getlist_options.columns = objects;
    getlist_options.equals = db.format(subject + ' = ?',[options.user]);

    getlist_options.since = 'id >= '+ (options['since_id']?options['since_id']:0);
    getlist_options.order = options.order;
    getlist_options.limit = options.limit;
    getlist_options.pk_res = objects;
    utils.get_list(success,error,getlist_options);
};

class FollowingManager{
    static table(){
        return "Followings";
    }
    static follow(subject,object,success,error){
        let insert_options = {
            data: {
                'follower': subject,
                'followee': object
            },
            table: this.table()
        };
        db.insert(insert_options).then(
        function(result){
            success(result);
        }).catch(function(err){
            error(err);
        });
    }
    static unfollow(subject,object, success,error){
        let where = 'followee =? and follower=?';
        where=db.format(where,[object,subject]);
        let delete_options = {
            'where': where,
            table: this.table()
        };
        db.delete(delete_options).then(
            function(result){
                success(result);
            }).catch(function(err){
                error(err);
        });
    }
    static list_followers (options, success, error){
        follow_list('followers',options,success,error);
    }
    static list_following (options, success ,error){
        follow_list('following',options,success,error);
    }
}
exports.FollowingManager = FollowingManager;
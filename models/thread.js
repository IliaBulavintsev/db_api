"use strict";
const Attribute = require('./base').Attribute;
const User = require('./user').User;
const Forum = require('./forum').Forum;
const Model = require('./base').Model;
const db = require('../db');
const utils= require('../utils');
const dateformat = require('dateformat');

const IS_DELETED = 1;
const IS_CLOSED = 2;
const FULL_MASK = 3;

const DATE_FORMAT = 'yyyy-mm-dd HH:MM:ss';

const set_is_deleted = function(method,id ,success,error){
    let sql = 'CALL ' + method+'_thread(?)';
    sql = db.format(sql,[id]);
    db.query(sql).then(function(result){
        success(result);
    }).catch(function(err){
        error(err);
    });
};

class Thread extends Model{
    constructor(){
        super();
        this.table = 'Threads';
        this._id = new Attribute('id','');
        this._state = new Attribute('state','');
        this._message = new Attribute('message','');
        this._date = new Attribute('date','');
        this._likes = new Attribute('likes',0);
        this._dislikes = new Attribute('dislikes',0);
        this._slug = new Attribute('slug','');
        this._title = new Attribute('title','');
        this._user = new Attribute('user','');
        this._forum = new Attribute('forum','');
        this._posts = new Attribute('posts','');
    }
    get id(){
        return this._id.value;
    }
    get isDeleted(){
        return (this._state.value & IS_DELETED) != 0;
    }
    get isClosed(){
        return (this._state.value & IS_CLOSED) != 0;
    }
    get date(){
        return dateformat(this._date.value,DATE_FORMAT);
    }
    get slug(){
        return this._slug.value;
    }
    get title(){
        return this._title.value;
    }
    get likes(){
        return this._likes.value;
    }
    get dislikes(){
        return this._dislikes.value;
    }
    get points(){
        return (this.likes - this.dislikes);
    }
    get posts(){
        return this._posts.value;
    }
    get user(){
        return this._user.value;
    }
    get forum(){
        return this._forum.value;
    }
    get message(){
        return this._message.value;
    }

    set id(new_value){
        this._id.value =new_value;
    }
    set isClosed(new_value){
        if (new_value)
            this._state.value |= IS_CLOSED;
        else
            this._state.value &=FULL_MASK-IS_CLOSED;
    }
    set isDeleted(new_value){
        if (new_value)
            this._state.value |= IS_DELETED;
        else
            this._state.value &=FULL_MASK - IS_DELETED;
    }
    set date(new_value){
        this._date.value = new_value;
    }
    set likes(new_value){
        this._likes.value = new_value;
    }
    set dislikes(new_value){
        this._dislikes.value = new_value;
    }
    set title(new_value){
        this._title.value = new_value;
    }
    set slug(new_value){
        this._slug.value = new_value;
    }
    set posts(new_value){
        this._posts.value = new_value;
    }
    set user(new_value){
        this._user.value = new_value;
    }
    set forum(new_value){
        this._forum.value = new_value;
    }
    set message(new_value){
        this._message.value = new_value;
    }

    fetch(success,error,options){
        let sql = 'SELECT * FROM Threads WHERE id = ?';
        sql = db.format(sql,[this.id]);
        db.query(sql).then(function (result) {
            if(result.length) {
                this.copy(result[0]);
                this._state.value = result[0].stateMask;
                let related = [];
                if (options['related'] && options['related'].has('user')) {
                    this.user = new User();
                    this.user.email = result[0].user;
                    related.push(this.user);
                }
                if (options['related'] && options['related'].has('forum')) {

                    this.forum = new Forum();
                    this.forum.short_name = result[0].forum;
                    related.push(this.forum);
                }
                if(related.length){
                    utils.array_fetch(related,success,error,{});
                }
                else {
                    success(result);
                }
            }
            else{
                let e = new Error('Thread with id' + this.id + ' not found!');
                e.type ='not_found';
                error(e);
            }
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    save(success,error,options){
        let insert_options = {
            data: {
                'stateMask': this._state.value,
                'slug': this.slug,
                'user': this.user,
                'title': this.title,
                'forum': this.forum,
                'message':this.message,
                'date':this.date
            },
            table: this.table
        };
        db.insert(insert_options).then(function (result) {
            this.id = result.insertId;
            success(result);
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    update(success,error,options){
        let update_options = {
            'set': 'message = ?, slug = ?',
            'where': 'id= ' +   this.id ,
            'table': this.table
        };
        update_options['set'] = db.format(update_options['set'],[options.message, options.slug]);
        db.update(update_options).then(function (result) {
            this.fetch(success,error,{});
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    remove(success,error,options) {
        set_is_deleted('delete',this.id,success,error);
    }
    restore(success,error,options) {
        set_is_deleted('restore',this.id,success,error);
    }
    open(success,error,options) {
        let update_options = {
            'set': 'stateMask = stateMask & (' + (FULL_MASK-IS_CLOSED)+')',
            'where': 'id= ' +  this.id ,
            'table': this.table
        };
        db.update(update_options).then(function (result) {
            success(result);
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    close(success,error,options) {
        let update_options = {
            'set': 'stateMask = stateMask | ('+ IS_CLOSED +')',
            'where': 'id= ' +  this.id ,
            'table': this.table
        };
        db.update(update_options).then(function (result) {
            success(result);
        }.bind(this)).catch(function (err) {
            error(err);
        })
    }
    vote(success,error, options){
        let set_stmt = '';
        if (options.vote == 1){
            set_stmt = 'likes = likes +1';
        }
        else if (options.vote == -1){
            set_stmt = 'dislikes = dislikes +1';
        }
        else{
            error(new Error('Semantic error'));
        }
        let update_options = {
            'set': set_stmt,
            'where': 'id= ' + this.id,
            'table': this.table
        };
        db.update(update_options).then(function (result) {
            this.fetch(success,error,{});
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    toJSON(){
        let result = super.toJSON();
        result.isClosed = this.isClosed;
        result.isDeleted = this.isDeleted;
        result.points = this.points;
        return result;
    }
}
module.exports.Thread = Thread;
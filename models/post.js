"use strict";
const Attribute = require('./base').Attribute;
const Model = require('./base').Model;
const Forum = require('../models/forum').Forum;
const Thread = require('../models/thread').Thread;
const User = require('../models/user').User;
const utils = require('../utils');
const db = require('../db');
const dateformat =require('dateformat');

const IS_APPROVED = 1;
const IS_DELETED =2;
const IS_EDITED = 4;
const IS_HIGHLIGHTED =8;
const IS_SPAM=16;
const FULL_MASK =31;
const DATE_FORMAT ="yyyy-mm-dd HH:MM:ss";

class Post extends Model {
    constructor(){
        super();
        this.table = 'Posts';
        this._id = new Attribute('id','');
        this._state = new Attribute('state','');
        this._date = new Attribute('date','');
        this._likes = new Attribute('likes','');
        this._dislikes = new Attribute('dislikes','');
        this._message = new Attribute('message','');
        this._parent = new Attribute('parent','');
        this._thread = new Attribute('thread','');
        this._user = new Attribute('user','');
        this._forum = new Attribute('forum','');
    }
    get id(){
        return this._id.value;
    }
    get isApproved(){
        return (this._state.value & IS_APPROVED) !== 0;
    }
    get isDeleted(){
        return (this._state.value & IS_DELETED) !== 0;
    }
    get isEdited(){
        return (this._state.value & IS_EDITED) !== 0;
    }
    get isHighlighted(){
        return (this._state.value & IS_HIGHLIGHTED) !== 0;
    }
    get isSpam(){
        return (this._state.value & IS_SPAM) !== 0;
    }
    get date(){
        return dateformat(this._date.value,DATE_FORMAT);
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
    get message(){
        return this._message.value;
    }
    get parent(){
        return this._parent.value;
    }
    get thread(){
        return this._thread.value;
    }
    get user(){
        return this._user.value;
    }
    get forum(){
        return this._forum.value;
    }

    set id(new_value){
        this._id.value =new_value;
    }
    set isApproved(new_value){
        if (new_value)
             this._state.value |= IS_APPROVED;
        else
            this._state.value &=FULL_MASK - IS_APPROVED;
    }
    set isDeleted(new_value){
        if (new_value)
            this._state.value |= IS_DELETED;
        else
            this._state.value &= FULL_MASK - IS_DELETED;
    }
    set isEdited(new_value){
        if (new_value)
            this._state.value |= IS_EDITED;
        else
            this._state.value &= FULL_MASK - IS_EDITED;
    }
    set isHighlighted(new_value){
        if (new_value)
            this._state.value |= IS_HIGHLIGHTED;
        else
            this._state.value &=FULL_MASK -  IS_HIGHLIGHTED;
    }
    set isSpam(new_value){
        if (new_value)
            this._state.value |= IS_SPAM;
        else
            this._state.value &=FULL_MASK -  IS_SPAM;
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
    set message(new_value){
        this._message.value = new_value;
    }
    set parent(new_value){
        this._parent.value = new_value;
    }
    set thread(new_value){
        this._thread.value = new_value;
    }
    set user(new_value){
        this._user.value = new_value;
    }
    set forum(new_value){
        this._forum.value = new_value;
    }
    fetch(success,error,options){
        let sql = 'SELECT * FROM Posts WHERE id = ?';
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
                if (options['related'] && options['related'].has('thread')) {

                    this.thread = new Thread();
                    this.thread.id = result[0].thread;
                    related.push(this.thread);
                }
                if(related.length){
                    utils.array_fetch(related,success,error,{});
                }
                else {
                    success(result);
                }
            }
            else{
                let e = new Error('Post with id' + this.id + ' not found!');
                e.type ='not_found';
                error(e);
            }
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    save(success,error,options){
        /*CREATE FUNCTION insert_post    (_thread INT,
            _user VARCHAR(30),
            _forum VARCHAR(50),
            _parent INT,
            _date TIMESTAMP,
            _message VARCHAR(15000),
            _stateMask TINYINT)*/

        var sql = 'SELECT insert_post(?,?,?,?,?,?,?) as id';
        sql = db.format(sql,[
              this.thread,
              this.user,
              this.forum,
              (this.parent != null)?this.parent:0,
              this.date,
              this.message,
              this._state.value
        ]);
        console.log(sql);
        db.query(sql).then(function(result){
            console.log(result);
            this.id = result[0].id;
            console.log(this.id);
            success(result);
        }.bind(this)).catch(function(err){
            error(err);
        });
        //db.insert(insert_options).then(function (result) {
        //    this.id = result.insertId;
        //    success(result);
        //}.bind(this)).catch(function (err) {
        //    error(err);
        //});
    }
    remove(success,error,options) {
        let update_options = {
            'set': 'stateMask = stateMask | (' + IS_DELETED+')',
            'where': 'id= ' +  this.id ,
            'table': this.table
        };
        db.update(update_options).then(function (result) {
            success(result);
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    restore(success,error,options) {
        let update_options = {
            'set': 'stateMask = stateMask & (' + (FULL_MASK-IS_DELETED)+')',
            'where': 'id= ' +  this.id ,
            'table': this.table
        };
        db.update(update_options).then(function (result) {
            success(result);
        }.bind(this)).catch(function (err) {
            error(err);
        });
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
        // update_options['set'] = db.format(update_options['set'],[this.about, this.name]);
        db.update(update_options).then(function (result) {
            this.fetch(success,error,{});
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    update(success,error,options){
        let update_options = {
            'set': 'message = ?',
            'where': 'id= ' +   this.id ,
            'table': this.table
        };
        update_options['set'] = db.format(update_options['set'],[options.message]);
        db.update(update_options).then(function (result) {
            this.fetch(success,error,{});
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
    toJSON(){
        let result = super.toJSON();
        result.isApproved = this.isApproved;
        result.isDeleted = this.isDeleted;
        result.isEdited = this.isEdited;
        result.isHighlighted = this.isHighlighted;
        result.isSpam = this.isSpam;
        result.points = this.points;
        result.parent = this.parent ? this.parent:null;
        return result;
    }
}
module.exports.Post = Post;

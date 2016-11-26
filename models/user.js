"use strict";
const Attribute = require('./base').Attribute;
const Model = require('./base').Model;
//const Thread = require('./models').Thread;
const db = require('../db');


class User  extends Model {
    constructor(email){
        super();
        this.table = 'Users';
        this._email = new Attribute('email', '');
        this._id = new Attribute('id', '');
        this._name = new Attribute('name', '');
        this._username = new Attribute('username', '');
        this._about = new Attribute('about', '');
        this._isAnonymous = new Attribute('isAnonymous', '');
        this._following = new Attribute ('following', undefined);
        this._followers = new Attribute ('followers',undefined);
        this._subscriptions = new  Attribute ('subscriptions',undefined);
    }
    /*static get table(){
        return users;
    }*/
    get email(){
        return this._email.value;
    }
    get id(){
        return this._id.value;
    }
    get name(){
        return this._name.value;
    }
    get username(){
        return this._username.value;
    }
    get about(){
        return this._about.value;
    }
    get isAnonymous(){
        return (this._isAnonymous.value === 1);
    }
    get following(){
        return this._following.value;
    }
    get followers(){
        return this._followers.value;
    }
    get subscriptions(){
        return this._subscriptions.value;
    }

    set email(new_value){
        this._email.value = new_value;
    }
    set id(new_value){
        this._id.value=new_value;
    }
    set name(new_value){
        this._name.value=new_value;
    }
    set username(new_value){
        this._username.value=new_value;
    }
    set about(new_value){
        this._about.value=new_value;
    }
    set isAnonymous(new_value){
        this._isAnonymous.value=(new_value)?1:0;
    }
    set following(new_value){
        this._following.value=new_value;
    }
    set followers(new_value){
        this._followers.value=new_value;
    }
    set subscriptions(new_value){
        this._subscriptions.value = new_value;
    }

    save(success, error, options) {
        let insert_options = {
            data: {
                'name': this.name,
                'email': this.email,
                'username': this.username,
                'isAnonymous': this.isAnonymous,
                'about': this.about
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
    fetch(success, error, options){
        var select_options ={
            columns :['U.id','U.email','U.about','U.name','U.username', 'U.isAnonymous' , 'F.followee', 'F.follower','S.thread'],
            from: 'Users as U left join Followings as F on (F.follower=U.email or F.followee = U.email) left join Subscriptions as S on S.user=U.email',
            where: 'U.email = '+'\''+this.email+'\''
        };
        db.select(select_options).then(function(result){
            if(result.length) {
                this.copy(result[0]);
                let aux_sets = {
                    followers: new Set(),
                    following: new Set(),
                    subscriptions: new Set()
                };
                for (let i = 0; i < result.length; i++) {
                    if (result[i]['follower'] && result[i]['follower']!== this.email)
                        aux_sets.followers.add(result[i]['follower']);
                    if (result[i]['followee'] && result[i]['followee']!== this.email)
                        aux_sets.following.add(result[i]['followee']);
                    if (result[i]['thread'])
                        aux_sets.subscriptions.add(result[i]['thread']);
                }
                for (let set_key in aux_sets) {
                    this[set_key] = [];
                    for (let elem of aux_sets[set_key]) {
                        this[set_key].push(elem);
                    }
                }
                success(result);
            } else{
                let e = new Error('User with email' + this.email + ' not found!');
                e.type ='not_found';
                error(e);
            }
        }.bind(this)).catch(function(err){
            error(err);
        })
    }
    update(success, error, options){

        let update_options = {
            'set': 'about = ?, name = ?',
            'where': 'email= ' + '\'' + this.email +'\'',
            'table': this.table
        };
        update_options['set'] = db.format(update_options['set'],[this.about, this.name]);
        db.update(update_options).then(function (result) {
            this.fetch(success,error);
        }.bind(this)).catch(function (err) {
            error(err);
        });
    }
}
module.exports.User = User;

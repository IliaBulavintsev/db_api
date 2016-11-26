var express = require('express');
var express_router = express.Router();

var forum =  require('./forum');
var post =   require('./post');
var thread = require('./thread');
var user =   require('./user');
var common = require('./common');
var utils = require('../utils');


express_router.use( '/post', function(req){
    "use strict";
    req.next(utils.check_related(req.query.related,"Posts"));
});
express_router.use( '/thread', function(req){
    "use strict";
    req.next(utils.check_related(req.query.related,"Threads"));
});



express_router.use( '/forum', forum);
express_router.use( '/post', post);
express_router.use( '/thread', thread);
express_router.use( '/user', user);
express_router.use( '/', common);

module.exports = express_router;

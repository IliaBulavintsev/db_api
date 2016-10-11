'use strict';

let express = require('express'),
    router = express.Router(),
    forum = require('./forum'),
    post = require('./post'),
    thread = require('./thread'),
    user = require('./user');

router.use( '/forum', forum);
router.use( '/post', post);
router.use( '/thread', thread);
router.use( '/user', user);

module.exports = router;

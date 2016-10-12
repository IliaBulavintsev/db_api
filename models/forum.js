'use strict';

class Forum {
  constructor(opt) {
    if (opt) {
      this.id = opt.id;
      this.name = opt.name;
      this.short_name = opt.short_name;
      this.user = opt.user;
    }
  }
}

module.exports.Forum = Forum;

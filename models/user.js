'use strict';

class User {
  constructor(opt) {
    if (opt) {
      this.email = opt.email;
      this.id = opt.id;
      this.name = opt.name;
      this.username = opt.username;
      this.about = opt.about;
      this.isAnonymous = opt.isAnonymous;
    }
  }
}

module.exports.User = User;

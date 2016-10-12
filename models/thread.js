'use strict';

class Thread {
  constructor(opt) {
    if (opt) {
      this.id = opt.id;
      this.isClosed = opt.isClosed;
      this.isDeleted = opt.isDeleted;
      this.message = opt.message;
      this.date = opt.date;
      this.likes = opt.likes;
      this.dislikes = opt.dislikes;
      this.slug = opt.slug;
      this.title = opt.title;
      this.user = opt.user;
      this.forum = opt.forum;
      this.posts = opt.posts;
    }
  }
}

module.exports.Thread = Thread;

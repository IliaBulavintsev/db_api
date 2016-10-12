'use strict';

class Post {
  constructor(opt) {
    if (opt) {
      this.id =   opt.id;
      this._state = 0;
      this.isApproved = opt.isApproved;
      this.isDeleted = opt.isDeleted;
      this.isEdited = opt.isEdited;
      this.isHighlighted = opt.isHighlighted;
      this.isSpam = opt.isSpam;
      this.date = opt.date;
      this.likes = opt.likes;
      this.dislikes = opt.dislikes;
      this.message = opt.message;
      this.parent = opt.parent;
      this.thread = opt.thread;
      this.user = opt.user;
      this.forum = opt.forum;
    }
  }
}

module.exports.Post = Post;

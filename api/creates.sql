SET foreign_key_checks = 0;
DROP TABLE IF Exists Users;
CREATE TABLE Users (
  id int NOT NULL AUTO_INCREMENT,
  email VARCHAR(30) NOT NULL,
  about VARCHAR(5000), -- NOT NULL,
  isAnonymous tinyint NOT NULL,
  name VARCHAR(30) ,
  username VARCHAR(30),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
)DEFAULT CHARSET=utf8;;

DROP TABLE IF Exists Followings;
CREATE TABLE Followings (
followee VARCHAR(30) NOT NULL,
follower VARCHAR (30) NOT NULL,
KEY followee (followee),
KEY follower (follower),
CONSTRAINT `Foll_ibfk_1` FOREIGN KEY (followee) REFERENCES Users (email) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `Foll_ibfk_2` FOREIGN KEY (follower) REFERENCES Users (email) ON DELETE CASCADE ON UPDATE CASCADE
)DEFAULT CHARSET=utf8;;

DROP TABLE IF Exists Forums;
CREATE TABLE Forums (
id int(10) NOT NULL AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
short_name VARCHAR(50) NOT NULL,
user VARCHAR(30) NOT NULL,
PRIMARY KEY (id),
UNIQUE KEY name(name),
UNIQUE KEY short_name(short_name),
KEY user (user),
CONSTRAINT `Forums_ibfk_1` FOREIGN KEY (user)   REFERENCES Users   (email) ON DELETE CASCADE ON UPDATE CASCADE
)DEFAULT CHARSET=utf8;;


DROP TABLE IF Exists Threads;
CREATE TABLE Threads (
id INT NOT NULL AUTO_INCREMENT,
forum VARCHAR(50) NOT NULL,
title VARCHAR(100) NOT NULL,
user VARCHAR(30) NOT NULL,
date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
message VARCHAR(10000) NOT NULL,
slug VARCHAR(100) NOT NULL,
stateMask TINYINT NOT NULL,
likes INT NOT NULL,
dislikes INT NOT NULL,
posts INT NOT NULL,
PRIMARY KEY(id),
KEY forum (forum),
KEY user  (user),
CONSTRAINT `Threads_ibfk_1` FOREIGN KEY (forum)  REFERENCES Forums  (short_name) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `Threads_ibfk_2` FOREIGN KEY (user)   REFERENCES Users   (email)      ON DELETE CASCADE ON UPDATE CASCADE
)DEFAULT CHARSET=utf8;;


DROP TABLE IF Exists Subscriptions;
CREATE TABLE Subscriptions (
user VARCHAR(30) NOT NULL,
thread INT NOT NULL,
KEY thread (thread),
KEY user  (user),
CONSTRAINT `Subs_ibfk_1` FOREIGN KEY (thread) REFERENCES Threads (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `Subs_ibfk_2` FOREIGN KEY (user)   REFERENCES Users   (email) ON DELETE CASCADE ON UPDATE CASCADE
)DEFAULT CHARSET=utf8;;

DROP TABLE IF Exists Posts;
CREATE TABLE Posts (
id INT NOT NULL AUTO_INCREMENT,
date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
message VARCHAR(150000) NOT NULL,-- not correct
parent INT NOT NULL DEFAULT 0,
stateMask TINYINT NOT NULL DEFAULT 0,
likes INT NOT NULL DEFAULT 0,
dislikes INT NOT NULL DEFAULT 0,
path VARCHAR(500) NOT NULL DEFAULT '',
root VARCHAR(7) NOT NULL DEFAULT '',
PRIMARY KEY(id),
thread INT NOT NULL,
user VARCHAR(30) NOT NULL,
forum VARCHAR(30) NOT NULL,
KEY forum (forum),
KEY thread (thread),
KEY user   (user),
CONSTRAINT Posts_ibfk_1 FOREIGN KEY (forum)  REFERENCES Forums  (short_name) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Posts_ibfk_2 FOREIGN KEY (thread) REFERENCES Threads (id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Posts_ibfk_3 FOREIGN KEY (user)   REFERENCES Users   (email) ON DELETE CASCADE ON UPDATE CASCADE
) DEFAULT CHARSET=utf8;


DELIMITER |
--DROP TRIGGER IF EXISTS update_posts_count_oninsert|
--CREATE TRIGGER update_posts_count_oninsert AFTER INSERT ON Posts FOR EACH ROW
--BEGIN
--    IF (NEW.stateMask & 2) = 0 THEN
--        UPDATE Threads SET posts=posts+1 WHERE id= NEW.thread;
--    END IF;
--END|

DROP TRIGGER IF EXISTS update_posts_count_onupdate|
CREATE TRIGGER update_posts_count_onupdate AFTER UPDATE ON Posts FOR EACH ROW
BEGIN
    IF ((NEW.stateMask & 2) != 0  AND (OLD.stateMask & 2) = 0) THEN
        UPDATE Threads SET posts=posts - 1 WHERE id= NEW.thread;
    ELSEIF ((NEW.stateMask & 2) = 0  AND (OLD.stateMask & 2) != 0) THEN
        UPDATE Threads SET posts=posts + 1 WHERE id= NEW.thread;
    END IF;
END|
DELIMITER ;


DELIMITER //
DROP PROCEDURE IF EXISTS delete_thread//
CREATE PROCEDURE delete_thread(IN thread_id INT)
BEGIN
  START TRANSACTION;
  update Threads SET stateMask = (stateMask | 1) WHERE id=thread_id;
  update Posts SET stateMask = (stateMask | 2) WHERE thread=thread_id;
  COMMIT;
END //
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS restore_thread//
CREATE PROCEDURE restore_thread(IN thread_id INT)
BEGIN
  START TRANSACTION;
  update Threads SET stateMask = (stateMask & ~1) WHERE id=thread_id;
  update Posts SET stateMask = (stateMask  & ~2) WHERE thread=thread_id;
  COMMIT;
END //
DELIMITER ;


DELIMITER //
DROP Function IF EXISTS insert_post//
CREATE FUNCTION insert_post    (_thread INT,
								_user VARCHAR(30),
                                _forum VARCHAR(50),
                                _parent INT,
                                _date TIMESTAMP,
                                _message VARCHAR(15000),
								_stateMask TINYINT)
RETURNS INT
BEGIN

    DECLARE parent_path VARCHAR(500);
    DECLARE root_post VARCHAR(7);
    DECLARE new_path VARCHAR(500);
    DECLARE new_id INT(7) ZEROFILL;

     IF (_stateMask & 2) = 0 THEN
            UPDATE Threads SET posts=posts+1 WHERE id= _thread;
     END IF;

    INSERT INTO Posts  (thread,user,forum,parent,date,message,stateMask)
    VALUES (_thread,_user, _forum,_parent,_date, _message, _stateMask);
    SET new_id = LAST_INSERT_ID();
    IF (_parent != 0) THEN
        SELECT path INTO parent_path FROM Posts WHERE id = _parent;
        SELECT root INTO root_post FROM Posts WHERE id = _parent;
		SET new_path = CONCAT(parent_path,'.',CAST(new_id AS CHAR));
    ELSE
        SET new_path = CAST(new_id AS CHAR);
        SET root_post = new_path;
    END IF;

    UPDATE Posts SET path = new_path, root = root_post WHERE id = new_id;
    RETURN new_id;
END//
DELIMITER ;

DELIMITER //
DROP PROCEDURE IF EXISTS parent_tree_post_list//
CREATE PROCEDURE parent_tree_post_list(IN _thread INT,
                                       IN _since TIMESTAMP,
                                       IN _order VARCHAR (4),
                                       IN _limit INT)
BEGIN
    IF (_order = 'asc') THEN
        SELECT id FROM Posts as P INNER JOIN
        (SELECT  root FROM Posts WHERE parent=0 AND thread= _thread AND date >= _since ORDER BY root LIMIT  _limit) as T
        ON P.root =T.root
        WHERE P.thread= _thread AND P.date >= _since
        ORDER BY P.path;
    ELSE
        SELECT id FROM Posts as P INNER JOIN
        (SELECT root FROM Posts WHERE parent=0 AND thread= _thread AND date >= _since ORDER BY root DESC LIMIT  _limit ) as T
        ON P.root =T.root
        WHERE P.thread=_thread and P.date >= _since
        ORDER BY P.root DESC , P.path ASC;
    END IF;

END//
DELIMITER ;

SET foreign_key_checks = 1;

DELIMITER //
DROP PROCEDURE IF EXISTS init//
CREATE PROCEDURE init()
BEGIN
SET @POST_IS_APPROVED = 1;
SET @POST_IS_DELETED =2;
SET @POST_IS_EDITED = 4;
SET @POST_IS_HIGHLIGHTED =8;
SET @POST_IS_SPAM=16;
SET @POST_FULL_MASK =31;

SET @THREAD_IS_DELETED = 1;
SET @THREAD_IS_CLOSED = 2;
SET @THREAD_FULL_MASK = 3;
END//

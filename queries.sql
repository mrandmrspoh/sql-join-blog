-- all the users that commented on ia single post (ex. post id 1)
SELECT users.name, posts.*
FROM posts INNER JOIN users
ON posts.author_id = users.id
AND id =1;

-- all the comments for post 39
SELECT
comments.content AS comments,
posts.id AS post_id,
posts.content AS post
FROM posts LEFT JOIN comments
ON comments.post_id = posts.id;

-- all the users that commented on their own post
SELECT users.name, a.*
FROM
    (SELECT
    posts.title AS title,
    posts.content AS content,
    comments.content AS comment,
    comments.author_id AS comment_author_id,
    posts.author_id AS post_author_id
    FROM posts INNER JOIN comments
    ON posts.author_id = comments.author_id) a
    INNER JOIN users
    ON users.id = a.post_author_id;

-- create a join table for post and user to store likes ( a post can have many likes, a user can like many posts )
CREATE TABLE IF NOT EXISTS likes (
    post_id INTEGER,
    user_id INTEGER,
    created_at DATE DEFAULT current_timestamp
    PRIMARY KEY (post_id, user_id)
);

-- create a query to get all the likes a user has made
SELECT a.user_id, users.name, posts.id, posts.title, posts.content
FROM
    (SELECT * FROM likes) a
    INNER JOIN users
    ON users.id = a.user_id)
    INNER JOIN posts
    ON posts.id = a.post_id
WHERE a.user_id = '';

-- create a query to get all users that like a post
SELECT a.user_id, users.name, posts.id, posts.title, posts.content
FROM
    (SELECT * FROM likes) a
    INNER JOIN users
    ON users.id = a.user_id)
    INNER JOIN posts
    ON posts.id = a.post_id
WHERE a.post_id = '';

-- create a query to get all the posts a user has liked
SELECT a.user_id, users.name, posts.id, posts.title, posts.content
FROM
    (SELECT * FROM likes) a
    INNER JOIN users
    ON users.id = a.user_id)
    INNER JOIN posts
    ON posts.id = a.post_id
WHERE a.user_id = '';
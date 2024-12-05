-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_all_comment_likes ()
BEGIN
    SELECT * FROM comment_like;
END //

CREATE OR REPLACE PROCEDURE get_comment_like_by_id (
    IN p_comment_like_id INT
)
BEGIN
    SELECT * FROM comment_like
    WHERE comment_like_id = p_comment_like_id;
END //

CREATE PROCEDURE get_all_likes_by_comment (
    IN p_comment_id INT
)
BEGIN
    SELECT
        cl.like_id,
        cl.person_id,
        cl.comment_id
    FROM
        comment_like cl
    WHERE
        cl.comment_id = p_comment_id
    ORDER BY
        cl.like_id ASC;
END //

CREATE PROCEDURE get_all_likes_by_person (
    IN p_person_id INT
)
BEGIN
    SELECT
        cl.like_id,
        cl.person_id,
        cl.comment_id
    FROM
        comment_like cl
    WHERE
        cl.person_id = p_person_id
    ORDER BY
        cl.like_id ASC;
END //

DELIMITER ;

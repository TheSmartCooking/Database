-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_comment_like(1, 1);
CALL insert_comment_like(1, 2);
CALL insert_comment_like(1, 3);
CALL insert_comment_like(2, 1);
CALL insert_comment_like(2, 2);
CALL insert_comment_like(3, 1);
CALL insert_comment_like(3, 2);
CALL insert_comment_like(3, 3);
CALL insert_comment_like(3, 4);
CALL insert_comment_like(4, 1);

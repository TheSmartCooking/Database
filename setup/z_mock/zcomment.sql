-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_comment('This is a comment.', 1, 1);
CALL insert_comment('This is another comment.', 2, 1);
CALL insert_comment('This is a third comment.', 3, 1);
CALL insert_comment('This is a fourth comment.', 4, 1);
CALL insert_comment('This is a comment on another recipe.', 1, 2);
CALL insert_comment('This is another comment on another recipe.', 2, 2);
CALL insert_comment('This is a third comment on another recipe.', 3, 2);
CALL insert_comment('This is a fourth comment on another recipe.', 4, 2);
CALL insert_comment('This is a comment on a third recipe.', 1, 3);
CALL insert_comment('This is another comment on a third recipe.', 2, 3);
CALL insert_comment('This is a third comment on a third recipe.', 3, 3);
CALL insert_comment('This is a comment on a fourth recipe.', 1, 4);

-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_picture_avatar('avatar1.jpg', 1);
CALL insert_picture_avatar('avatar2.jpg', 2);
CALL insert_picture_avatar('avatar3.jpg', 3);

CALL insert_picture_language_icon('language_icon1.jpg', 1);
CALL insert_picture_language_icon('language_icon2.jpg', 2);
CALL insert_picture_language_icon('language_icon3.jpg', 3);

CALL insert_picture_recipe_picture('recipe_picture1.jpg', 1);
CALL insert_picture_recipe_picture('recipe_picture2.jpg', 2);
CALL insert_picture_recipe_picture('recipe_picture3.jpg', 3);

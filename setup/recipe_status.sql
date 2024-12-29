-- Use the database
USE smartcooking;

CALL insert_recipe_status('draft'); -- ID 1 is the default status
CALL insert_recipe_status('published');
CALL insert_recipe_status('hidden');
CALL insert_recipe_status('archived');
CALL insert_recipe_status('pending review');
CALL insert_recipe_status('rejected');
CALL insert_recipe_status('scheduled');
CALL insert_recipe_status('needs update');
CALL insert_recipe_status('unlisted');
CALL insert_recipe_status('deleted');

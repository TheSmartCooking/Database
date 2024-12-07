-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe(1, 1, 30, 3, 'Not so many calories', 'www.source.com', 'www.video.com', 'draft');
CALL insert_recipe(2, 2, 45, 2, 'A lot of calories', 'www.source.com', 'www.video.com', 'pending review');
CALL insert_recipe(3, 3, 60, 1, 'Homer Simpson would be fed for days', 'www.source.com', 'www.video.com', 'draft');
CALL insert_recipe(4, 4, 75, 3, '1 kcal', 'www.source.com', 'www.video.com', 'pending review');
CALL insert_recipe(4, 5, 90, 2, 'infinity calories', 'www.source.com', 'www.video.com', 'draft');

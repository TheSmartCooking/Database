-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_recipe(
    IN author_id INT,
    IN picture_id INT NULL,
    IN cook_time INT UNSIGNED NULL,
    IN difficulty_level TINYINT,
    IN nutritional_information TEXT NULL,
    IN source VARCHAR(255) NULL,
    IN video_url VARCHAR(255) NULL,
    IN recipe_status ('draft', 'pending review') NOT NULL DEFAULT 'pending review'
)
BEGIN
    INSERT INTO recipe (author_id, picture_id, cook_time, difficulty_level, nutritional_information, source, video_url, recipe_status)
    VALUES (author_id, picture_id, cook_time, difficulty_level, nutritional_information, source, video_url, recipe_status);
END //

DELIMITER ;

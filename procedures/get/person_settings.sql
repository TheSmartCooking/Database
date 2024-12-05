-- Use the database
USE smartcooking;

DELIMITER //

-- This procedure is intended for testing purposes only
CREATE OR REPLACE PROCEDURE get_person_settings(IN p_person_id INT)
BEGIN
    SELECT setting_key, setting_value
    FROM person_setting
    WHERE person_id = p_person_id;
END //

CREATE PROCEDURE get_person_settings_analytics()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_settings_count (
        setting_key VARCHAR(100),
        setting_value VARCHAR(255),
        user_count INT
    );

    INSERT INTO temp_settings_count (setting_key, setting_value, user_count)
    SELECT
        setting_key,
        setting_value,
        COUNT(person_id) AS user_count
    FROM
        person_setting
    GROUP BY
        setting_key,
        setting_value;

    SELECT * FROM temp_settings_count;

    DROP TEMPORARY TABLE IF EXISTS temp_settings_count;
END //

DELIMITER ;

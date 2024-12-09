-- Use the database
USE smartcooking;

DELIMITER //

CREATE OR REPLACE PROCEDURE insert_person_responsibility(
    IN p_person_id INT,
    IN p_responsibility_id INT
)
BEGIN
    INSERT INTO person_responsibility (person_id, responsibility_id)
    VALUES (p_person_id, p_responsibility_id);
END //

CREATE OR REPLACE PROCEDURE insert_person_responsibility_by_name(
    IN p_person_id INT,
    IN p_responsibility_name VARCHAR(100)
)
BEGIN
    DECLARE v_responsibility_id INT;

    SELECT responsibility_id
    INTO v_responsibility_id
    FROM responsibility
    WHERE responsibility_name = p_responsibility_name;

    CALL insert_person_responsibility(p_person_id, v_responsibility_id);
END //

CREATE OR REPLACE PROCEDURE make_person_default_user(
    IN p_person_id INT
)
BEGIN
    -- Comment management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_comment_on_recipe');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_edit_own_comment');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_own_comment');

    -- Ingredient management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_create_ingredient');

    -- Media management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_upload_picture');

    -- Recipe management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_create_recipe');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_edit_own_recipe');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_own_recipe');

    -- Tag management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_create_tag');

    -- Translation management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_add_translation');
END //

CREATE OR REPLACE PROCEDURE make_person_verified_user(
    IN p_person_id INT
)
BEGIN
    CALL make_person_default_user(p_person_id);

    -- Recipe management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_publish_recipe');
END //

CREATE OR REPLACE PROCEDURE make_person_moderator(
    IN p_person_id INT
)
BEGIN
    CALL make_person_default_user(p_person_id);

    -- Comment management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_edit_any_comment');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_any_comment');

    -- Media management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_picture');

    -- Moderation
    CALL insert_person_responsibility_by_name(p_person_id, 'can_review_flagged_content');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_suspend_user_account');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_ban_user_account');

    -- Person management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_manage_any_person_profile');

    -- Recipe management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_review_recipe');
END //

CREATE OR REPLACE PROCEDURE make_person_administrator(
    IN p_person_id INT
)
BEGIN
    CALL make_person_moderator(p_person_id);

    -- Administrative
    CALL insert_person_responsibility_by_name(p_person_id, 'can_manage_roles');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_view_audit_log');

    -- Category management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_create_category');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_edit_category');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_category');

    -- Ingredient management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_edit_ingredient');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_ingredient');

    -- Person management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_any_person_account');

    -- Tag management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_edit_tag');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_tag');

    -- Translation management
    CALL insert_person_responsibility_by_name(p_person_id, 'can_edit_translation');
    CALL insert_person_responsibility_by_name(p_person_id, 'can_delete_translation');
END //

DELIMITER ;

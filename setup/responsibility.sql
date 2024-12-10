-- Use the database
USE smartcooking;

-- Administrative
CALL insert_responsibility('can_manage_roles');
CALL insert_responsibility('can_view_audit_log');

-- Category management
CALL insert_responsibility('can_create_category');
CALL insert_responsibility('can_edit_category');
CALL insert_responsibility('can_delete_category');

-- Comment management
CALL insert_responsibility('can_comment_on_recipe');
CALL insert_responsibility('can_edit_own_comment');
CALL insert_responsibility('can_edit_any_comment');
CALL insert_responsibility('can_delete_own_comment');
CALL insert_responsibility('can_delete_any_comment');

-- Ingredient management
CALL insert_responsibility('can_create_ingredient');
CALL insert_responsibility('can_edit_ingredient');
CALL insert_responsibility('can_delete_ingredient');

-- Media management
CALL insert_responsibility('can_upload_picture');
CALL insert_responsibility('can_delete_picture');

-- Moderation
CALL insert_responsibility('can_review_flagged_content');
CALL insert_responsibility('can_suspend_user_account');
CALL insert_responsibility('can_ban_user_account');

-- Person management
CALL insert_responsibility('can_manage_any_person_profile');
CALL insert_responsibility('can_delete_any_person_account');

-- Recipe management
CALL insert_responsibility('can_create_recipe');
CALL insert_responsibility('can_edit_own_recipe');
CALL insert_responsibility('can_edit_any_recipe');
CALL insert_responsibility('can_delete_own_recipe');
CALL insert_responsibility('can_delete_any_recipe');
CALL insert_responsibility('can_publish_recipe');
CALL insert_responsibility('can_review_recipe');

-- Tag management
CALL insert_responsibility('can_create_tag');
CALL insert_responsibility('can_edit_tag');
CALL insert_responsibility('can_delete_tag');

-- Translation management
CALL insert_responsibility('can_add_translation');
CALL insert_responsibility('can_edit_translation');
CALL insert_responsibility('can_delete_translation');

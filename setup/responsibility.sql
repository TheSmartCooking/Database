-- Use the database
USE smartcooking;

-- Administrative
CALL insert_responsibility(
    'can_manage_roles',
    'Allows the ability to create, edit, or delete user roles and their associated permissions.'
);
CALL insert_responsibility(
    'can_view_audit_log',
    'Allows access to view detailed records of database activities' ||
    ' and changes for auditing purposes.'
);

-- Category management
CALL insert_responsibility(
    'can_create_category',
    'Grants the ability to create new categories for organizing content.'
);
CALL insert_responsibility(
    'can_edit_category',
    'Allows editing existing categories to update their details.'
);
CALL insert_responsibility(
    'can_delete_category',
    'Grants permission to remove categories from the database.'
);

-- Comment management
CALL insert_responsibility(
    'can_comment_on_recipe',
    'Enables the user to post comments on recipes.'
);
CALL insert_responsibility(
    'can_edit_own_comment',
    'Allows users to edit their own comments.'
);
CALL insert_responsibility(
    'can_edit_any_comment',
    'Grants the ability to modify any comment in the system.'
);
CALL insert_responsibility(
    'can_delete_own_comment',
    'Enables users to delete their own comments.'
);
CALL insert_responsibility(
    'can_delete_any_comment',
    'Grants the ability to remove any comment from the system.'
);

-- Ingredient management
CALL insert_responsibility(
    'can_create_ingredient',
    'Allows the addition of new ingredients to the database.'
);
CALL insert_responsibility(
    'can_edit_ingredient',
    'Grants permission to modify existing ingredient details.'
);
CALL insert_responsibility(
    'can_delete_ingredient',
    'Allows the removal of ingredients from the database.'
);

-- Media management
CALL insert_responsibility(
    'can_upload_picture',
    'Enables users to upload pictures to the system.'
);
CALL insert_responsibility(
    'can_delete_picture',
    'Grants the ability to remove pictures from the system.'
);

-- Moderation
CALL insert_responsibility(
    'can_review_flagged_content',
    'Allows reviewing and managing content flagged as inappropriate.'
);
CALL insert_responsibility(
    'can_suspend_user_account',
    'Grants the ability to temporarily suspend a user’s account.'
);
CALL insert_responsibility(
    'can_ban_user_account',
    'Enables the banning of user accounts permanently.'
);

-- Person management
CALL insert_responsibility(
    'can_manage_any_person_profile',
    'Grants access to edit profiles of any user in the system.'
);
CALL insert_responsibility(
    'can_delete_any_person_account',
    'Allows the permanent removal of any user account.'
);

-- Recipe management
CALL insert_responsibility(
    'can_create_recipe',
    'Allows users to create and submit new recipes.'
);
CALL insert_responsibility(
    'can_edit_own_recipe',
    'Grants users the ability to edit their own recipes.'
);
CALL insert_responsibility(
    'can_edit_any_recipe',
    'Allows editing any recipe in the system.'
);
CALL insert_responsibility(
    'can_delete_own_recipe',
    'Enables users to delete their own recipes.'
);
CALL insert_responsibility(
    'can_delete_any_recipe',
    'Grants the ability to remove any recipe from the system.'
);
CALL insert_responsibility(
    'can_publish_recipe',
    'Allows the publication of recipes to make them publicly visible.'
);
CALL insert_responsibility(
    'can_review_recipe',
    'Grants permission to review recipes for approval or feedback.'
);

-- Tag management
CALL insert_responsibility(
    'can_create_tag',
    'Allows the creation of new tags for categorizing content.'
);
CALL insert_responsibility(
    'can_edit_tag',
    'Grants the ability to edit existing tags.'
);
CALL insert_responsibility(
    'can_delete_tag',
    'Allows the removal of tags from the database.'
);

-- Translation management
CALL insert_responsibility(
    'can_add_translation',
    'Enables the addition of new translations for system content.'
);
CALL insert_responsibility(
    'can_edit_translation',
    'Grants permission to modify existing translations.'
);
CALL insert_responsibility(
    'can_delete_translation',
    'Allows the deletion of translations from the database.'
);

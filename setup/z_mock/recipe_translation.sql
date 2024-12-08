-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_recipe_translation_by_iso_code(1, 'en', 'Title 1', 'Details 1', 'Preparation 1');
CALL insert_recipe_translation_by_iso_code(1, 'es', 'Título 1', 'Detalles 1', 'Preparación 1');
CALL insert_recipe_translation_by_iso_code(2, 'en', 'Title 2', 'Details 2', 'Preparation 2');
CALL insert_recipe_translation_by_iso_code(2, 'es', 'Título 2', 'Detalles 2', 'Preparación 2');
CALL insert_recipe_translation_by_iso_code(3, 'en', 'Title 3', 'Details 3', 'Preparation 3');
CALL insert_recipe_translation_by_iso_code(3, 'es', 'Título 3', 'Detalles 3', 'Preparación 3');
CALL insert_recipe_translation_by_iso_code(4, 'en', 'Title 4', 'Details 4', 'Preparation 4');
CALL insert_recipe_translation_by_iso_code(4, 'es', 'Título 4', 'Detalles 4', 'Preparación 4');

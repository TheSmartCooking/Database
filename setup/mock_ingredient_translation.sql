-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_ingredient_translation_by_iso_code('en', 'Salt');
CALL insert_ingredient_translation_by_iso_code('en', 'Pepper');
CALL insert_ingredient_translation_by_iso_code('en', 'Sugar');
CALL insert_ingredient_translation_by_iso_code('fr', 'Sel');
CALL insert_ingredient_translation_by_iso_code('fr', 'Poivre');
CALL insert_ingredient_translation_by_iso_code('fr', 'Sucre');
CALL insert_ingredient_translation_by_iso_code('de', 'Salz');
CALL insert_ingredient_translation_by_iso_code('de', 'Pfeffer');
CALL insert_ingredient_translation_by_iso_code('de', 'Zucker');
CALL insert_ingredient_translation_by_iso_code('es', 'Sal');
CALL insert_ingredient_translation_by_iso_code('es', 'Pimienta');
CALL insert_ingredient_translation_by_iso_code('es', 'Azúcar');

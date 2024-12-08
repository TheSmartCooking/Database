-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_language_icon_by_iso_code('en', 1);
CALL insert_language_icon_by_iso_code('de', 2);
CALL insert_language_icon_by_iso_code('fr', 3);
CALL insert_language_icon_by_iso_code('es', 4);
CALL insert_language_icon_by_iso_code('it', 5);
CALL insert_language_icon_by_iso_code('pt', 6);
CALL insert_language_icon_by_iso_code('nl', 7);
CALL insert_language_icon_by_iso_code('pl', 8);
CALL insert_language_icon_by_iso_code('ru', 9);

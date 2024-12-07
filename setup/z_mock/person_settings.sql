-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_person_setting(1, 'theme', 'light');
CALL insert_person_setting(2, 'theme', 'dark');
CALL insert_person_setting(2, 'profile_visibility', 'private');
CALL insert_person_setting(3, 'theme', 'light');
CALL insert_person_setting(3, 'profile_visibility', 'public');

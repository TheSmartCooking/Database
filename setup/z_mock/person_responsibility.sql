-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL make_person_default_user(1);
CALL make_person_verified_user(2);
CALL make_person_moderator(3);
CALL make_person_administrator(4);

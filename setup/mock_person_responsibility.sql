-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL insert_person_responsibility(1, 1);
CALL insert_person_responsibility(1, 2);
CALL insert_person_responsibility(2, 3);
CALL insert_person_responsibility(2, 4);
CALL insert_person_responsibility(3, 5);
CALL insert_person_responsibility(4, 6);

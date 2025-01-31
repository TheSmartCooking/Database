-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL register_person('John Doe', 'john.doe@mock.data', 'password', 'en');
CALL register_person('Jane Smith', 'jane.smith@mock.data', 'password', 'fr');
CALL register_person('Alice Brown', 'alice.brown@mock.data', 'password', 'es');
CALL register_person('Bob White', 'bob.white@mock.data', 'password', 'en');

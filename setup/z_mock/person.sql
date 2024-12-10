-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL register_person('John Doe', 'john.doe@mock.data', 'password', UNHEX('a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6'), 'en');
CALL register_person('Jane Smith', 'jane.smith@mock.data', 'password', UNHEX('f1e2d3c4b5a6978899aabbccddeeff00'), 'fr');
CALL register_person('Alice Brown', 'alice.brown@mock.data', 'password', UNHEX('0123456789abcdef0123456789abcdef'), 'es');
CALL register_person('Bob White', 'bob.white@mock.data', 'password', UNHEX('fedcba9876543210fedcba9876543210'), 'en');

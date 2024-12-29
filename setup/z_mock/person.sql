-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL register_person('John Doe', 'john.doe@mock.data', 'password', unhex('a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6'), 'en');
CALL register_person('Jane Smith', 'jane.smith@mock.data', 'password', unhex('f1e2d3c4b5a6978899aabbccddeeff00'), 'fr');
CALL register_person('Alice Brown', 'alice.brown@mock.data', 'password', unhex('0123456789abcdef0123456789abcdef'), 'es');
CALL register_person('Bob White', 'bob.white@mock.data', 'password', unhex('fedcba9876543210fedcba9876543210'), 'en');

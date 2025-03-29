-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL register_person('John Doe', 'hashed_email1', 'encrypted_email1', 'password', 'en');
CALL register_person('Jane Smith', 'hashed_email2', 'encrypted_email2', 'password', 'fr');
CALL register_person('Alice Brown', 'hashed_email3', 'encrypted_email3', 'password', 'es');
CALL register_person('Bob White', 'hashed_email4', 'encrypted_email4', 'password', 'en');

-- Use the database
USE smartcooking;

-- Fill the database with mock data
CALL register_person(
    'John Doe',
    'john.doe@mock.data',
    UNHEX('5e884898da28047151d0e56f8dc62927'),
    UNHEX('a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6')
);

CALL register_person(
    'Jane Smith',
    'jane.smith@mock.data',
    UNHEX('8cb2237d0679ca88db6464eac60da963'),
    UNHEX('f1e2d3c4b5a6978899aabbccddeeff00')
);

CALL register_person(
    'Alice Brown',
    'alice.brown@mock.data',
    UNHEX('e99a18c428cb38d5f260853678922e03'),
    UNHEX('0123456789abcdef0123456789abcdef')
);

CALL register_person(
    'Bob White',
    'bob.white@mock.data',
    UNHEX('3e23e8160039594a33894f6564e1b134'),
    UNHEX('fedcba9876543210fedcba9876543210')
);

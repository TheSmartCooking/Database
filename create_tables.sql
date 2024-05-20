DROP TABLE IF EXISTS recipe_tag;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS recipe;

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    registration_date DATETIME,
    last_login DATETIME,
    is_admin BOOLEAN DEFAULT FALSE
);

CREATE TABLE recipe (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    title VARCHAR(255),
    description TEXT,
    ingredients TEXT,
    preparation TEXT,
    publication_date DATETIME,
    modification_date DATETIME,
    likes INT,
    image VARCHAR(255),
    cuisine VARCHAR(255),
    course VARCHAR(255),
    prep_time INT,
    cook_time INT,
    total_time INT,
    servings INT,
    difficulty_level VARCHAR(255),
    rating FLOAT,
    number_of_reviews INT,
    video_url VARCHAR(255),
    nutritional_information TEXT,
    comments TEXT,
    source_url VARCHAR(255),
    user_favorites INT,
    allergen_information TEXT,
    flavor_profile VARCHAR(255),
    status ENUM('verified', 'liked', 'hidden', 'banned') NULL,
    FOREIGN KEY (author_id) REFERENCES user(user_id) ON DELETE CASCADE
);

CREATE TABLE tag (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE
);

CREATE TABLE recipe_tag (
    recipe_id INT,
    tag_id INT,
    PRIMARY KEY (recipe_id, tag_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tag(tag_id) ON DELETE CASCADE
);

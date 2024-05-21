DROP TABLE IF EXISTS recipe_tag;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS recipe_like;
DROP TABLE IF EXISTS comment_like;
DROP TABLE IF EXISTS user_avatar;
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS recipe;

CREATE TABLE user_avatar (
    avatar_id INT AUTO_INCREMENT PRIMARY KEY,
    avatar_path VARCHAR(255) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    registration_date DATETIME,
    last_login DATETIME,
    is_admin BOOLEAN DEFAULT FALSE,
    avatar_id INT,
    FOREIGN KEY (avatar_id) REFERENCES user_avatar(avatar_id) ON DELETE SET NULL
) ENGINE=InnoDB;

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
    nutritional_information TEXT,
    source VARCHAR(255),
    allergen_information TEXT,
    flavor_profile VARCHAR(255),
    video_url VARCHAR(255) NULL,
    status ENUM('verified', 'liked', 'hidden', 'banned') NULL,
    FOREIGN KEY (author_id) REFERENCES user(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tag (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    recipe_id INT,
    comment TEXT,
    comment_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recipe_like (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    recipe_id INT,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE comment_like (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    comment_id INT,
    FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recipe_tag (
    recipe_id INT,
    tag_id INT,
    PRIMARY KEY (recipe_id, tag_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tag(tag_id) ON DELETE CASCADE
) ENGINE=InnoDB;

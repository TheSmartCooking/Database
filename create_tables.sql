DROP TABLE IF EXISTS comment_like CASCADE;
DROP TABLE IF EXISTS comment CASCADE;
DROP TABLE IF EXISTS favorite CASCADE;
DROP TABLE IF EXISTS recipe_rating CASCADE;
DROP TABLE IF EXISTS recipe_tag CASCADE;
DROP TABLE IF EXISTS tag CASCADE;
DROP TABLE IF EXISTS recipe_ingredient CASCADE;
DROP TABLE IF EXISTS ingredient_translation CASCADE;
DROP TABLE IF EXISTS ingredient CASCADE;
DROP TABLE IF EXISTS recipe_translation CASCADE;
DROP TABLE IF EXISTS recipe CASCADE;
DROP TABLE IF EXISTS person_setting CASCADE;
DROP TABLE IF EXISTS person_responsibility CASCADE;
DROP TABLE IF EXISTS responsibility CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS status CASCADE;
DROP TABLE IF EXISTS locale CASCADE;
DROP TABLE IF EXISTS image CASCADE;

CREATE TABLE image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    image_path VARCHAR(255) UNIQUE,
    image_type ENUM('avatar', 'recipe', 'locale_icon') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE locale (
    locale_id INT AUTO_INCREMENT PRIMARY KEY,
    locale_code VARCHAR(10) UNIQUE,
    locale_name VARCHAR(50) UNIQUE,
    icon_image_id INT NULL,
    FOREIGN KEY (icon_image_id) REFERENCES image(image_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE person (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    salt VARBINARY(16),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    avatar_image_id INT NULL,
    locale_id INT NULL,
    FOREIGN KEY (avatar_image_id) REFERENCES image(image_id) ON DELETE SET NULL,
    FOREIGN KEY (locale_id) REFERENCES locale(locale_id) ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE person_setting (
    person_id INT,
    setting_key VARCHAR(100),
    setting_value VARCHAR(255),
    PRIMARY KEY (person_id, setting_key),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE responsibility (
    responsibility_id INT AUTO_INCREMENT PRIMARY KEY,
    responsibility_name VARCHAR(100) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE person_responsibility (
    person_id INT,
    responsibility_id INT,
    PRIMARY KEY (person_id, responsibility_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (responsibility_id) REFERENCES responsibility(responsibility_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE ingredient (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    default_name VARCHAR(255) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE ingredient_translation (
    ingredient_id INT,
    locale_id INT,
    translated_name VARCHAR(255),
    PRIMARY KEY (ingredient_id, locale_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id) ON DELETE CASCADE,
    FOREIGN KEY (locale_id) REFERENCES locale(locale_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recipe (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    publication_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modification_date TIMESTAMP NULL,
    image_id INT NULL,
    cook_time INT UNSIGNED NULL,
    difficulty_level TINYINT CHECK (difficulty_level BETWEEN 1 AND 3),
    number_of_reviews INT NULL,
    nutritional_information TEXT NULL,
    source VARCHAR(255) NULL,
    video_url VARCHAR(255) NULL,
    status_id INT,
    FOREIGN KEY (author_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (image_id) REFERENCES image(image_id) ON DELETE SET NULL,
    FOREIGN KEY (status_id) REFERENCES status(status_id)
) ENGINE=InnoDB;

CREATE TABLE recipe_translation (
    recipe_id INT,
    locale_id INT,
    title VARCHAR(255),
    description TEXT,
    preparation TEXT,
    PRIMARY KEY (recipe_id, locale_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (locale_id) REFERENCES locale(locale_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE tag (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE recipe_ingredient (
    recipe_id INT,
    ingredient_id INT,
    quantity VARCHAR(50),
    unit VARCHAR(50),
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE recipe_tag (
    recipe_id INT,
    tag_id INT,
    PRIMARY KEY (recipe_id, tag_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tag(tag_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    recipe_id INT,
    comment TEXT,
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE comment_like (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    comment_id INT,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comment(comment_id) ON DELETE CASCADE,
    UNIQUE (person_id, comment_id)
) ENGINE=InnoDB;

CREATE TABLE favorite (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    recipe_id INT,
    favorited_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE,
    UNIQUE (person_id, recipe_id)
) ENGINE=InnoDB;

CREATE TABLE recipe_rating (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    recipe_id INT,
    rating TINYINT CHECK (rating BETWEEN 1 AND 4),
    FOREIGN KEY (person_id) REFERENCES person(person_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe(recipe_id) ON DELETE CASCADE,
    UNIQUE (person_id, recipe_id)
) ENGINE=InnoDB;

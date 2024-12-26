-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS smartcooking;

-- Use the database
USE smartcooking;

CREATE OR REPLACE TABLE lang (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    iso_code CHAR(2) UNIQUE,
    english_name VARCHAR(30) UNIQUE,
    native_name VARCHAR(30) UNIQUE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE person (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    person_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    hashed_password VARCHAR(100),
    salt BINARY(16),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    language_id INT NULL,
    FOREIGN KEY (language_id) REFERENCES lang (language_id) ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE picture (
    picture_id INT AUTO_INCREMENT PRIMARY KEY,
    picture_path VARCHAR(65) UNIQUE,
    author_id INT NULL,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    picture_type ENUM('avatar', 'recipe', 'language_icon') NOT NULL,
    FOREIGN KEY (author_id) REFERENCES person (person_id) ON DELETE SET NULL
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE person_avatar (
    person_id INT NOT NULL UNIQUE,
    avatar_picture_id INT NOT NULL,
    PRIMARY KEY (person_id, avatar_picture_id),
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (avatar_picture_id) REFERENCES picture (picture_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE lang_icon (
    language_id INT NOT NULL UNIQUE,
    icon_picture_id INT NOT NULL,
    PRIMARY KEY (language_id, icon_picture_id),
    FOREIGN KEY (language_id) REFERENCES lang (language_id) ON DELETE CASCADE,
    FOREIGN KEY (icon_picture_id) REFERENCES picture (picture_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE person_setting (
    person_id INT,
    setting_key VARCHAR(100),
    setting_value VARCHAR(255),
    PRIMARY KEY (person_id, setting_key),
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    UNIQUE (person_id, setting_key)
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE responsibility (
    responsibility_id INT AUTO_INCREMENT PRIMARY KEY,
    responsibility_name VARCHAR(100) UNIQUE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE person_responsibility (
    person_id INT,
    responsibility_id INT,
    PRIMARY KEY (person_id, responsibility_id),
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (responsibility_id) REFERENCES responsibility (responsibility_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE ingredient (
    ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    default_name VARCHAR(255) UNIQUE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE ingredient_translation (
    ingredient_id INT,
    language_id INT,
    translated_name VARCHAR(255),
    PRIMARY KEY (ingredient_id, language_id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredient (ingredient_id) ON DELETE CASCADE,
    FOREIGN KEY (language_id) REFERENCES lang (language_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE recipe (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT NULL,
    publication_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modification_date TIMESTAMP NULL,
    picture_id INT NULL,
    cook_time INT UNSIGNED NULL,
    difficulty_level TINYINT CHECK (difficulty_level BETWEEN 1 AND 3),
    number_of_reviews INT NULL,
    source VARCHAR(255) NULL,
    recipe_status ENUM('draft', 'published', 'hidden', 'archived', 'pending review', 'rejected', 'scheduled', 'needs update', 'unlisted', 'deleted') NOT NULL DEFAULT 'draft',
    FOREIGN KEY (author_id) REFERENCES person (person_id) ON DELETE SET NULL,
    FOREIGN KEY (picture_id) REFERENCES picture (picture_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE recipe_ingredient (
    recipe_id INT,
    ingredient_id INT,
    quantity DECIMAL(10, 2),
    unit VARCHAR(10),
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (ingredient_id) REFERENCES ingredient (ingredient_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE recipe_translation (
    recipe_id INT,
    language_id INT,
    title VARCHAR(255),
    details TEXT,
    preparation TEXT,
    nutritional_information TEXT NULL,
    video_url VARCHAR(255) NULL,
    PRIMARY KEY (recipe_id, language_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (language_id) REFERENCES lang (language_id) ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE recipe_engagement (
    engagement_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT NOT NULL,
    recipe_id INT NOT NULL,
    engagement_type ENUM('like', 'favorite', 'view') NOT NULL,
    engagement_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    UNIQUE (person_id, recipe_id, engagement_type)
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE tag (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(25) UNIQUE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE recipe_tag (
    recipe_id INT,
    tag_id INT,
    PRIMARY KEY (recipe_id, tag_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tag (tag_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id INT,
    recipe_id INT,
    content TEXT,
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (author_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE comment_like (
    person_id INT,
    comment_id INT,
    PRIMARY KEY (person_id, comment_id),
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comment (comment_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE recipe_rating (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    recipe_id INT,
    rating TINYINT CHECK (rating BETWEEN 1 AND 4),
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    UNIQUE (person_id, recipe_id)
) ENGINE = InnoDB;

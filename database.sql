-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS smartcooking;

-- Use the database
USE smartcooking;

CREATE OR REPLACE TABLE lang (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    iso_code VARCHAR(2) UNIQUE,
    language_name VARCHAR(30) UNIQUE,
    native_name VARCHAR(30) UNIQUE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE person (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    person_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    hashed_password VARCHAR(100),
    salt VARBINARY(16),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    language_id INT NULL,
    FOREIGN KEY (language_id) REFERENCES lang (language_id) ON DELETE SET NULL
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    image_path VARCHAR(255) UNIQUE,
    author_id INT NULL,
    image_type ENUM('avatar', 'recipe', 'lang_icon') NOT NULL,
    FOREIGN KEY (author_id) REFERENCES person (person_id) ON DELETE SET NULL
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE person_avatar (
    person_id INT NOT NULL,
    avatar_image_id INT NOT NULL,
    PRIMARY KEY (person_id, avatar_image_id),
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (avatar_image_id) REFERENCES image (image_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE lang_icon (
    language_id INT NOT NULL,
    icon_image_id INT NOT NULL,
    PRIMARY KEY (language_id, icon_image_id),
    FOREIGN KEY (language_id) REFERENCES lang (language_id) ON DELETE CASCADE,
    FOREIGN KEY (icon_image_id) REFERENCES image (image_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) UNIQUE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE person_setting (
    person_id INT,
    setting_key VARCHAR(100),
    setting_value VARCHAR(255),
    PRIMARY KEY (person_id, setting_key),
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE
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
    FOREIGN KEY (author_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (image_id) REFERENCES image (image_id) ON DELETE SET NULL,
    FOREIGN KEY (status_id) REFERENCES status (status_id)
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE recipe_translation (
    recipe_id INT,
    language_id INT,
    title VARCHAR(255),
    description TEXT,
    preparation TEXT,
    PRIMARY KEY (recipe_id, language_id),
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE,
    FOREIGN KEY (language_id) REFERENCES lang (language_id) ON DELETE CASCADE
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

CREATE OR REPLACE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    recipe_id INT,
    comment TEXT,
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (recipe_id) REFERENCES recipe (recipe_id) ON DELETE CASCADE
) ENGINE = InnoDB;

CREATE OR REPLACE TABLE comment_like (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    comment_id INT,
    FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comment (comment_id) ON DELETE CASCADE,
    UNIQUE (person_id, comment_id)
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

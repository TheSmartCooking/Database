# MariaDB SQL Database Generation

This repository contains SQL scripts to generate a database schema in MariaDB.
The schema includes tables for managing recipes, comments, users, tags, and more.

## Getting Started

To set up the database locally, you'll need Docker installed. Follow the steps below to build and run the database in a container.

### Setup Steps

1. **Build the Docker Image**:

   ```bash
   docker build -t smartcooking-mariadb .
   ```

2. **Run the Docker Container**:

   ```bash
   docker run -d -p 3306:3306 --name Smart-Cooking_Database -e MYSQL_ROOT_PASSWORD=myrootpassword smartcooking-mariadb
   ```

3. **Access the Database**:
   ```bash
   docker exec -it Smart-Cooking_Database mariadb -uroot -pmyrootpassword
   ```

## Database Schema Overview

The database schema consists of the following tables:

1. **image**: Stores image data for avatars and recipe images.
2. **person**: Contains information about users such as name, email, and registration date.
3. **responsibility**: Stores responsibilities associated with users.
4. **person_responsibility**: Defines a many-to-many relationship between persons and responsibilities.
5. **status**: Defines status options for recipes.
6. **locale**: Stores locale information for translations.
7. **recipe**: Represents individual recipes with details like author, cook time, and difficulty level.
8. **recipe_translation**: Stores translations of recipe details in different languages.
9. **tag**: Contains tags associated with recipes.
10. **comment**: Stores comments made by users on recipes.
11. **comment_like**: Tracks likes on comments.
12. **favorite**: Stores information about users' favorite recipes.
13. **recipe_tag**: Represents a many-to-many relationship between recipes and tags.
14. **recipe_rating**: Stores ratings given by users to recipes.

## Usage

1. **Clone the Repository**: Clone this repository to your local machine using `git clone`.

2. **Execute SQL Scripts**: Run the provided SQL scripts in your MariaDB environment to create the database schema.

3. **Customization**: Modify the schema or add additional features as per your requirements.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or create a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

# Use MariaDB version 11.5.2 as the base image
FROM mariadb:11.5.2

# Create a new user and group with limited privileges
RUN groupadd -r dbuser && useradd -r -g dbuser dbuser

# Copy SQL files from the repository root into the container
COPY create_database.sql /docker-entrypoint-initdb.d/
COPY create_tables.sql /docker-entrypoint-initdb.d/
COPY create_get_procedures.sql /docker-entrypoint-initdb.d/
COPY create_insert_procedures.sql /docker-entrypoint-initdb.d/
COPY create_update_procedures.sql /docker-entrypoint-initdb.d/
COPY create_delete_procedures.sql /docker-entrypoint-initdb.d/

# Add sample data to the database
COPY sample_data.sql /docker-entrypoint-initdb.d/

# Adjust permissions on the MySQL data directory
RUN chown -R dbuser:dbuser /var/lib/mysql

# Expose the default MariaDB port (3306)
EXPOSE 3306

# Switch to the new user
USER dbuser

# Add health check for the container
HEALTHCHECK --interval=1m --timeout=10s --start-period=30s --retries=3 \
    CMD mysqladmin ping -h localhost || exit 1

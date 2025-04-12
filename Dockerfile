# Use MariaDB version 11.5.2 as the base image
FROM mariadb:11.5.2

# Set environment variables
ENV TEMP_SQL_DIR=/temp-sql-files

# Set the shell for safer execution
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create a non-root user and group
RUN groupadd -r dbuser && useradd -r -g dbuser dbuser

# Copy files and scripts and set permissions
COPY . ${TEMP_SQL_DIR}/
COPY scripts/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Run the flattening script
RUN [ -f /usr/local/bin/flatten-sql-files.sh ] && \
    /usr/local/bin/flatten-sql-files.sh || echo "No flatten-sql-files.sh script found"

# Copy the flattened SQL files to the initialization directory
RUN chown -R dbuser:dbuser /docker-entrypoint-initdb.d && \
    chown -R dbuser:dbuser /var/lib/mysql /etc/mysql

# Expose the default MariaDB port (3306)
EXPOSE 3306

# Switch to the new user
USER dbuser

# Add health check for the container
HEALTHCHECK --interval=1m --timeout=10s --start-period=30s --retries=3 \
    CMD mysqladmin ping -h localhost || exit 1

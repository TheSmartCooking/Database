# Use MariaDB version 11.5.2 as the base image
FROM mariadb:11.5.2

# Set environment variables
ENV TEMP_SQL_DIR=/temp-sql-files

# Set the shell for safer execution
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy all files into a temporary location
COPY . ${TEMP_SQL_DIR}/

# Flatten the directory structure and rename files to include folder names
RUN find "${TEMP_SQL_DIR:?}/" -type f -name "*.sql" | while read -r file; do \
    new_name=$(echo "$file" | sed "s|${TEMP_SQL_DIR:?}/||" | sed 's|/|_|g' | sed 's|^_||'); \
    cp "$file" "/docker-entrypoint-initdb.d/$new_name"; \
    done && \
    rm -rf "${TEMP_SQL_DIR:?}/"

# Expose the default MariaDB port (3306)
EXPOSE 3306

# Switch to the mysql user
USER mysql

# Add health check for the container
HEALTHCHECK --interval=10s --timeout=5s --start-period=30s --retries=3 \
    CMD healthcheck.sh --connect --innodb_initialized || exit 1

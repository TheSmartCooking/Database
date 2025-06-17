# Use MariaDB version 11.5.2 as the base image
FROM mariadb:11.5.2

# Set environment variables
ENV TEMP_SQL_DIR=/temp-sql-files

# Set the shell for safer execution
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy all files into a temporary location
COPY . ${TEMP_SQL_DIR}/

# Run the flatten script
RUN chmod +x ${TEMP_SQL_DIR}/flatten-sql.sh && ${TEMP_SQL_DIR}/flatten-sql.sh

# Expose the default MariaDB port (3306)
EXPOSE 3306

# Switch to the mysql user
USER mysql

# Add health check for the container
HEALTHCHECK --interval=10s --timeout=5s --start-period=30s --retries=3 \
    CMD healthcheck.sh --connect --innodb_initialized || exit 1

#!/bin/bash
set -euo pipefail

TEMP_SQL_DIR="${TEMP_SQL_DIR:-/temp-sql-files}"

find "${TEMP_SQL_DIR:?}/" -type f -name "*.sql" | while read -r file; do
    new_name=$(echo "$file" | sed "s|${TEMP_SQL_DIR:?}/||" | sed 's|/|_|g' | sed 's|^_||')
    cp "$file" "/docker-entrypoint-initdb.d/$new_name"
done

rm -rf "${TEMP_SQL_DIR:?}/"

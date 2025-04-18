#!/bin/bash
set -euo pipefail

TEMP_SQL_DIR=${TEMP_SQL_DIR:-/temp-sql-files}
INITDB_DIR=${INITDB_DIR:-/docker-entrypoint-initdb.d}

echo "Flattening SQL files from $TEMP_SQL_DIR to $INITDB_DIR"

find "${TEMP_SQL_DIR:?}/" -type f -name "*.sql" | while read -r file; do
    new_name=$(echo "$file" | sed "s|${TEMP_SQL_DIR:?}/||" | sed 's|/|_|g' | sed 's|^_||')
    cp "$file" "${INITDB_DIR}/${new_name}"
done

rm -rf "${TEMP_SQL_DIR:?}/"

#!/bin/bash
set -e

echo "Running database initialization scripts..."

# Loop through subdirectories in /app/sql in alphabetical order
for dir in /app/sql/*/; do
    echo "Processing directory: $dir"
    # Run all .sql files in the directory in alphabetical order
    for file in "$dir"*.sql; do
        if [ -f "$file" ]; then
            echo "Executing $file..."
            psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f "$file"
        fi
    done
done

echo "Database initialization complete."

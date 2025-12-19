#!/bin/sh

### Wait for the database to be ready
until php -r "
new PDO(
  'mysql:host=$DB_HOST;dbname=$DB_NAME',
  '$DB_USER',
  '$DB_PASS'
);
" 2>/dev/null; do
  inform "Waiting for MariaDB..."
  sleep 2
done

inform "DB is ready."

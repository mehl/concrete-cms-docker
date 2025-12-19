#!/bin/sh

require_env() {
  [ -n "$2" ] || {
    inform "Missing ENV: $1"
    exit 1
  }
}
### Check if everything needed for installation is set

require_env DB_HOST "$DB_HOST"
require_env DB_NAME "$DB_NAME"
require_env DB_USER "$DB_USER"
require_env DB_PASS "$DB_PASS"
require_env DB_ROOT_PASS "$DB_ROOT_PASS"
# require_env MAIL_METHOD "$MAIL_METHOD"
# require_env MAIL_HOST "$MAIL_HOST"
# require_env MAIL_PORT "$MAIL_PORT"
# require_env MAIL_USER "$MAIL_USER"
# require_env MAIL_PASS "$MAIL_PASS"
# require_env MAIL_ENCRYPTION "$MAIL_ENCRYPTION"
require_env C5_SITE "$C5_SITE"
require_env C5_ADMIN_EMAIL "$C5_ADMIN_EMAIL"
require_env C5_ADMIN_PASSWORD "$C5_ADMIN_PASSWORD"


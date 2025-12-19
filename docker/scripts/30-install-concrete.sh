#!/bin/sh

### Run Concrete CMS installer if not yet installed

APP_ROOT="${APP_ROOT:-/var/www/html}"
CONCRETE_BIN="$APP_ROOT/concrete/bin/concrete"
INSTALLED_FLAG="$APP_ROOT/application/config/database.php"

if [ -f "$INSTALLED_FLAG" ]; then
  inform "Concrete CMS is already installed."
  return 0
fi

args="c5:install"

add() {
  [ -n "$2" ] && args="$args $1=\"$2\""
}

flag() {
  [ "$2" = "1" ] && args="$args $1"
}

# --- Pflichtwerte ---
add --db-server        "$DB_HOST"
add --db-username      "$DB_USER"
add --db-password      "$DB_PASS"
add --db-database      "$DB_NAME"
add --site             "$C5_SITE"
add --admin-email      "$C5_ADMIN_EMAIL"
add --admin-password   "$C5_ADMIN_PASSWORD"

# --- Optionale Werte ---
add --timezone                     "$TZ"
#add --env                          "$C5_ENV"
add --canonical-url                "$C5_CANONICAL_URL"
add --canonical-url-alternative    "$C5_CANONICAL_URL_ALT"
add --starting-point               "$C5_STARTING_POINT"
add --session-handler              "$C5_SESSION_HANDLER"
add --demo-username                "$C5_DEMO_USERNAME"
add --demo-password                "$C5_DEMO_PASSWORD"
add --demo-email                   "$C5_DEMO_EMAIL"
add --language                     "$C5_LANGUAGE"
add --site-locale                  "$C5_SITE_LOCALE"
add --config                       "$C5_CONFIG"

# --- Flags (1 = aktiv) ---
flag --attach                      "$C5_ATTACH"
flag --force-attach                "$C5_FORCE_ATTACH"
flag --disable-marketplace-connect "$C5_DISABLE_MARKETPLACE"
flag --defer-installation          "$C5_DEFER_INSTALLATION"
flag --ignore-warnings             "$C5_IGNORE_WARNINGS"

# --- Always set flags ---
flag --allow-as-root               "0"                        # not run as root, as this will give permission issues
flag --interactive                 "0"                        # (not supported in this script)
flag --no-interaction              "1"                        # always non-interactive

inform "Running Concrete CMS installer:"
echo "su-exec apache:app php $CONCRETE_BIN $args"
eval "su-exec apache:app php $CONCRETE_BIN $args"
inform "Concrete CMS installation completed."
beginTask() {
  prefix="⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ "
  echo "$prefix $1"
}

inform() {
  prefix="⣿⣿⣿⣿⣿⣿⣿         "
  echo "$prefix $1"
}

c5_config_set() {
    local key="$1"
    local value="$2"

    # If value is empty, skip setting it
    [ -n "$value" ] || return 0

    echo "Setting config: $key"
    su-exec apache:app php concrete/bin/concrete c5:config -g set "$key" "$value"
}

c5_package_install() {
    local package_handle="$1"

    echo "Installing package: $package_handle"
    su-exec apache:app php concrete/bin/concrete c5:package:install "$package_handle"
}
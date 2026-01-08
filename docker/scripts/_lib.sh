beginTask() {
  prefix="⣿⣿⣿ "
  echo "$prefix $1"
}

inform() {
  prefix="⣿   "
  echo "$prefix $1"
}

concrete_version() {
  local root="$1"
  local file="$root/concrete/config/concrete.php"

  [ -f "$file" ] || return 1

  sed -n "s/^[[:space:]]*'version'[[:space:]]*=>[[:space:]]*'\([^']*\)'.*/\1/p" "$file"
}

concrete_cli() {
  su-exec apache:app php concrete/bin/concrete "$@"
}


c5_config_set() {
    local key="$1"
    local value="$2"

    # If value is empty, skip setting it
    [ -n "$value" ] || return 0

    echo "Setting config: $key"
    concrete_cli c5:config -g set "$key" "$value"
}

c5_package_install() {
    local package_handle="$1"

    echo "Installing package: $package_handle"
    concrete_cli c5:package:install "$package_handle"
}

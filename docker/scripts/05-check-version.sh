#!/bin/sh

compare_concrete_versions() {
  local skeleton="$1"
  local webroot="$2"

  local v_skel v_web

  beginTask "Versionsvergleich: Skeleton ($skeleton) vs. Webroot ($webroot)"

  v_skel="$(concrete_version "$skeleton")" || {
    inform "ERROR: keine Version im Skeleton gefunden"
    return 2
  }

  v_web="$(concrete_version "$webroot")" || {
    inform "ERROR: keine Version im Webroot gefunden"
    return 2
  }

  # sort -V vergleicht Semver korrekt
  if [ "$v_skel" = "$v_web" ]; then
    inform "OK: Versionen identisch ($v_skel)"
    return 0
  fi

  if [ "$(printf "%s\n%s\n" "$v_skel" "$v_web" | sort -V | head -n1)" = "$v_skel" ]; then
    inform "ABBRUCH: Skeleton-Version ($v_skel) ist kleiner als Webroot ($v_web)"
    return 1
  fi

  inform "UPDATE: Skeleton-Version ($v_skel) ist neuer als Webroot ($v_web)"
  return 3
}

compare_concrete_versions "$C5_SKELETON" "$WEB_ROOT"

case $? in
  0) return 0 ;;
  1) return 0 ;;
  2) return 0 ;;
esac

update_concrete

return 0

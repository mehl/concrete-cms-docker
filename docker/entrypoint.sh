#!/bin/sh

. /scripts/_lib.sh
. /scripts/_update_concrete.sh

for f in /scripts/*.sh; do
  case "$(basename "$f")" in
    _*) continue ;;
  esac

  beginTask "$f"
  . "$f"
  inform ""
done

FLAG=/var/www/html/application/config/provisioned.settings

if [ ! -f "$FLAG" ]; then
  if ls /provisioning/*.sh >/dev/null 2>&1; then
    for f in /provisioning/*.sh; do
      beginTask "PROVISIONING $f"
      . "$f"
      inform ""
    done
    touch "$FLAG"
  else
    inform "No provisioning scripts found, skipping."
  fi
fi

exec "$@"

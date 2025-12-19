#!/bin/sh

. /scripts/_lib.sh

for f in /scripts/*.sh; do
  if [ "$f" = "/scripts/_lib.sh" ]; then
    continue
  fi
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

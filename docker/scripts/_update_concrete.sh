update_concrete() {
  local old_dir
  local v_web

  v_web="$(concrete_version "$WEB_ROOT")"
  old_dir="${WEB_ROOT}/concrete-${v_web}"

    inform "Updating Concrete CMS core from ${C5_SKELETON} to ${WEB_ROOT}..."
    mv "${WEB_ROOT}/concrete" "$old_dir" || return 1
    rsync -a "${C5_SKELETON}/concrete/" "${WEB_ROOT}/concrete/" || return 1
    chown -R apache:app "${WEB_ROOT}/concrete" || return 1
    su-exec apache:app php concrete/bin/concrete c5:update
    rm -rf "$old_dir" || return 1
    inform "Update completed."
}


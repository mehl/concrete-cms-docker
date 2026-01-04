#!/bin/sh

### Copy Concrete CMS source files to www root directory.

if [ -f "${WEB_ROOT}/index.php" ]; then
  inform "Files already copied."
  return 0
fi

inform "Copying Concrete CMS files from ${C5_SKELETON} to ${WEB_ROOT}..."
rsync -a --ignore-existing "${C5_SKELETON}/." "${WEB_ROOT}/"
chown -R apache:app "${WEB_ROOT}"
inform "Files copied."
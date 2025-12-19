#!/bin/sh

### Copy Concrete CMS source files to www root directory.

if [ -f "${WEB_ROOT}/index.php" ]; then
  inform "Files already copied."
  return 0
fi

inform "Copying Concrete CMS files to ${WEB_ROOT}..."
cp -a "${C5_SKELETON}/." "${WEB_ROOT}/"
chown -R apache:app "${WEB_ROOT}"
inform "Files copied."
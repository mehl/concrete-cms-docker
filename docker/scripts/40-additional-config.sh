#!/bin/sh


if [ -f "${WEB_ROOT}/application/config/production.concrete.php" ]; then
  inform "Concrete CMS is already configured."
  return 0
fi

inform "Copying default Concrete CMS configuration files..."

## Bind settings to ENV
cp application/config/production.concrete.default.php application/config/production.concrete.php
# cp application/config/production.database.default.php application/config/production.database.php

## Add additional language packages
concrete_cli c5:language-install --add ${C5_LANGUAGE}
concrete_cli c5:language-install --add ${C5_SITE_LOCALE}


## Currently unused settings
# c5_config_set concrete.seo.redirect_to_canonical_url "0"
# c5_config_set concrete.mail.method "$MAIL_METHOD"
# c5_config_set concrete.mail.methods.smtp.server "$MAIL_HOST"
# c5_config_set concrete.mail.methods.smtp.port "$MAIL_PORT"
# c5_config_set concrete.mail.methods.smtp.username "$MAIL_USER"
# c5_config_set concrete.mail.methods.smtp.password "$MAIL_PASS"
# c5_config_set concrete.mail.methods.smtp.encryption "$MAIL_ENCRYPTION"

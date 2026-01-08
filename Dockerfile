FROM alpine:3.19

LABEL maintainer="Bastian Frank"

ENV PHP_VERSION=83
ENV C5_VERSION=9.4.7
ENV C5_URL=https://www.concretecms.org/download_file/8bbe8ad7-1b48-4f2e-9d7e-fcc9258385e7
ENV C5_SKELETON=/opt/concrete

ENV APP_ROOT=/var/www/html
ENV WEB_ROOT=/var/www/html

ARG APACHE_UID=1000
ARG APACHE_GID=1000

# ------------------------------------------------------------
# System + PHP + Apache
# ------------------------------------------------------------
RUN apk add --no-cache \
    apache2 \
    cronie \
    php${PHP_VERSION} \
    php${PHP_VERSION}-apache2 \
    php${PHP_VERSION}-pdo_mysql \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-ctype \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-session \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-simplexml \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-tokenizer \
    php${PHP_VERSION}-pecl-imagick \
    tzdata \
    rsync \
    curl \
    unzip \
    su-exec

# ------------------------------------------------------------
# Apache basic setup (Alpine defaults + UID/GID matching)
RUN mkdir -p /run/apache2 \
 && deluser apache 2>/dev/null || true \
 && delgroup apache 2>/dev/null || true \
 && addgroup -g ${APACHE_GID} app \
 && adduser -D -u ${APACHE_UID} -G app apache \
 && sed -i \
    -e 's/^#LoadModule rewrite_module/LoadModule rewrite_module/' \
    -e 's/^User .*/User apache/' \
    -e 's/^Group .*/Group app/' \
    /etc/apache2/httpd.conf

# Ensure conf.d is included
RUN grep -q "conf.d" /etc/apache2/httpd.conf || \
    echo 'IncludeOptional /etc/apache2/conf.d/*.conf' >> /etc/apache2/httpd.conf

# ------------------------------------------------------------
# Concrete CMS
# ------------------------------------------------------------
WORKDIR /usr/src

# Use /var/www/html as document root
RUN mkdir -p ${WEB_ROOT}

RUN curl -fsSL ${C5_URL} -o concrete.zip \
 && unzip -q concrete.zip \
 && mv concrete-cms-${C5_VERSION} ${C5_SKELETON} \
 && rm -rf concrete.zip

# ------------------------------------------------------------
# Copy configs
# ------------------------------------------------------------
COPY docker/config/apache/000-concrete.conf /etc/apache2/conf.d/000-concrete.conf
COPY docker/config/apache/.htaccess /var/www/html/.htaccess
COPY docker/config/php/99-concrete.ini /etc/php83/conf.d/
COPY docker/config/concrete/production.concrete.php ${C5_SKELETON}/application/config/production.concrete.default.php
COPY docker/config/concrete/production.database.php ${C5_SKELETON}/application/config/production.database.default.php

# ------------------------------------------------------------
# Permissions (Concrete needs write access)
RUN chown -R apache:app ${APP_ROOT} \
 && chmod -R u+rwX ${APP_ROOT}

# Configure php

RUN ln -sf /usr/bin/php${PHP_VERSION} /usr/bin/php

# ------------------------------------------------------------
# Runtime
# ------------------------------------------------------------
WORKDIR ${WEB_ROOT}

COPY docker/scripts/ /scripts/
RUN chmod +x /scripts/*.sh
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY docker/crontab /etc/crontabs/root
RUN chown root:root /etc/crontabs/root && chmod 0600 /etc/crontabs/root

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["httpd", "-D", "FOREGROUND"]

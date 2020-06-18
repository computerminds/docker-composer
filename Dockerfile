FROM composer:1

MAINTAINER "Steven Jones" <steven.jones@computerminds.co.uk>

# Update composer
RUN composer self-update

# Trust github for git clones.
RUN mkdir -p ~/.ssh && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
# Trust alfresco for git clones.
RUN mkdir -p ~/.ssh && ssh-keyscan -t rsa gitlab.alfresco.com >> ~/.ssh/known_hosts

# Add Dockerize, as it's useful.
RUN \
  apk --no-cache add wget && \
  wget https://github.com/jwilder/dockerize/releases/download/v0.1.0/dockerize-linux-amd64-v0.1.0.tar.gz && \
  tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.1.0.tar.gz 
#  && \
#  apk remove -y wget && \
#  apt-get autoremove -y && \
#  apt-get clean all

# Add make composer faster plugin.
RUN composer global require hirak/prestissimo deviantintegral/composer-gavel

RUN composer --version

ADD composer.json /tmp/composer.json
# Warm the composer caches with our common config.
RUN \
  cd /tmp && \
  composer install --no-dev

# Add node and npm :(
RUN \
  apk add nodejs
#  curl -sL https://deb.nodesource.com/setup_6.x | bash - &&  \
#  apt update && apt install -y nodejs && \
#  apt-get clean all

RUN apk --no-cache add \
        php7 \
        php7-ctype \
        php7-curl \
        php7-dom \
        php7-fileinfo \
        php7-ftp \
        php7-iconv \
        php7-json \
        php7-mbstring \
        php7-mysqlnd \
        php7-openssl \
        php7-pdo \
        php7-pdo_sqlite \
        php7-pear \
        php7-phar \
        php7-posix \
        php7-session \
        php7-simplexml \
        php7-sqlite3 \
        php7-tokenizer \
        php7-xml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-zlib

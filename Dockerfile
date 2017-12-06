FROM composer/composer

MAINTAINER "Steven Jones" <steven.jones@computerminds.co.uk>

# Trust github for git clones.
RUN mkdir -p ~/.ssh && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
# Trust acquia for git clones.
RUN mkdir -p ~/.ssh && ssh-keyscan -t rsa git.acquia.com >> ~/.ssh/known_hosts
# Trust alfresco for git clones.
RUN mkdir -p ~/.ssh && ssh-keyscan -t rsa gitlab.alfresco.com >> ~/.ssh/known_hosts

# Add Dockerize, as it's useful.
RUN \
  apt-get update && apt-get install -y wget && \
  wget https://github.com/jwilder/dockerize/releases/download/v0.1.0/dockerize-linux-amd64-v0.1.0.tar.gz && \
  tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.1.0.tar.gz && \
  apt-get remove -y wget && \
  apt-get autoremove -y && \
  apt-get clean all

ADD composer.json /tmp/composer.json
# Warm the composer caches with our common config.
RUN \
  cd /tmp && \
  composer install --no-dev

# Add node and npm :(
RUN \
  curl -sL https://deb.nodesource.com/setup_8.x | bash - &&  \
  apt update && apt install -y nodejs && \
  apt-get clean all
  

#!/usr/bin/env bash

echo -e "ru_RU.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen

apt-get update
# Install packages to allow apt to use a repository over HTTPS:
apt-get install -y --no-install-recommends \
     locales \
     mc \
     screen \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common \
     git-core

# Add Docker’s official GPG key:
curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -

# Use the following command to set up the stable repository.
add-apt-repository "deb https://apt.dockerproject.org/repo/ debian-$(lsb_release -cs) main"

# Install the latest version of Docker
apt-get update
apt-get -y install docker-engine
systemctl enable docker

source ../wp-dock/.env

# create main user|group
#echo "Create group $GRP"
#groupadd $GRP
#echo "Create user $USR"
#useradd --create-home -d $HM -g $GRP -s /bin/bash $USR

# Add your user to the docker group.
usermod -aG docker $USR

# install compose
curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VER/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
&& chmod +x /usr/local/bin/docker-compose \
&& curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

mkdir $BACKUP_DIR
mkdir $MYSQL_DATA
mkdir $WP_CONTENT
mkdir $WP_CONTENT/upgrade
mkdir $WP_CONTENT/uploads
mkdir $WP_CONTENT/themes
mkdir $WP_CONTENT/plugins
chown -R www-data:www-data $WP_CONTENT

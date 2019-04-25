FROM ubuntu:xenial
RUN yes | apt update
RUN apt install -y  software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN yes | apt update
RUN apt install -y curl nano iputils-ping curl nginx
RUN export DEBIAN_FRONTEND=noninteractive
RUN apt install -y tzdata
RUN apt install -y git
RUN ln -fs /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt -y update && apt install -y less php7.1 php7.1-fpm php7.1-cli php7.1-mbstring php-mbstring php7.1-mcrypt php-intl php7.1-curl php7.1-gd php7.1-xml zip unzip php7.1-zip php-curl php7.1-mysql php-mysql php-pear php-dev php7.1-redis
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt install -y nodejs
RUN npm install -g forever babel-loader node-babel yarn
RUN sed -i -e "s/;clear_env\s*=\s*no/clear_env = no/g" /etc/php/7.1/fpm/pool.d/www.conf

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN cp ./composer.phar /usr/bin/composer
RUN ./composer.phar global require hirak/prestissimo

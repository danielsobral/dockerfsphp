FROM ubuntu:22.04

ENV timezone=America/Sao_Paulo

RUN apt update && \
    ln -snf /usr/share/zoneinfo/${timezone} /etc/localtime && echo ${timezone} > /etc/timezone && \
    apt install -y apache2 && \
    apt install -y php && \
    apt install -y php-xdebug && \
    apt install -y php-mysql && \
    apt install -y php-curl && \
    apt install -y php-zip && \
    apt install -y php-mbstring && \
    apt install -y php-xml && \
    apt install -y zip && \
    apt install -y unzip && \
    apt install -y git && \
    apt install -y curl && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php composer-setup.php && rm composer-setup.php && mv composer.phar /usr/local/bin/composer && chmod a+x /usr/local/bin/composer

EXPOSE 80
EXPOSE 3306

WORKDIR /var/www/html

ENTRYPOINT /etc/init.d/apache2 start && /bin/bash

CMD ["true"]

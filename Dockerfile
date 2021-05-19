FROM alpine:edge

RUN apk --update --no-cache add curl nginx py3-setuptools supervisor \
    php7-fpm php7-mbstring php7-gd php7-imap php7-ldap php7-session php7-simplexml \
    php7-zip php7-zlib php7-pdo_mysql php7-ctype php7-sodium php7-json
ADD supervisord.conf /etc/supervisord.conf

RUN curl -sSL https://github.com/LimeSurvey/LimeSurvey/archive/refs/tags/4.6.2+210512.tar.gz | tar -xvzf - --strip-components 1 -C /var/www/ \
    && chown -R nobody: /var/www/
ADD nginx.limesurvey.conf /etc/nginx/http.d/default.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
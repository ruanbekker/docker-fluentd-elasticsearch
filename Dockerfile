FROM fluent/fluentd:v0.12-onbuild
MAINTAINER Ruan Bekker <ruan@ruanbekker.com>
# https://hub.docker.com/r/fluent/fluentd/
# https://docs.fluentd.org/v1.0/articles/out_elasticsearch
# https://www.fluentd.org/plugins
USER root
ARG date
LABEL date=${date}
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \

 # cutomize following instruction as you wish
 && sudo gem install \
        fluent-plugin-secure-forward \
        fluent-plugin-elasticsearch \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem

EXPOSE 24284
USER fluent

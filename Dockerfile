FROM ruby:2.4.1-alpine

WORKDIR /devdocs

COPY devdocs /devdocs
COPY mylist.txt /devdocs

RUN apk --update add nodejs build-base libstdc++ gzip git zlib-dev && \
    gem install bundler && \
    bundle install --system --without test && \
    cat mylist.txt | while read R; do thor docs:download "$R"; done && \
    thor assets:compile && \
    apk del gzip build-base git zlib-dev && \
    rm -rf /var/cache/apk/* /tmp ~/.gem /root/.bundle/cache \
    /usr/local/bundle/cache /usr/lib/node_modules

EXPOSE 9292
CMD rackup -o 0.0.0.0


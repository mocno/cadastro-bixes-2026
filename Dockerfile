FROM ruby:2.7.1-alpine

ENV APP_PATH=/usr/src/app

WORKDIR ${APP_PATH}

RUN apk add --update \
    build-base git bash tzdata libxml2 postgresql-dev gcompat \
    && rm -rf /var/cache/apk/*

COPY . ./

RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD bundle exec rails server

EXPOSE ${PORT}

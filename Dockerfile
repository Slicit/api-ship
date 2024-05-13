FROM ruby:3.2.2-alpine3.17

ARG BUNDLER_ENV=test
ARG RAILS_ENV=test

RUN apk add --update \
  build-base \
  bash \
  vim \
  tzdata \
  postgresql-dev \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile /app/Gemfile

RUN bundle install

EXPOSE 3000

CMD ["./bin/rails", "server"]

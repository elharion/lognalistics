FROM ruby:2.6.5

ENV RUBY_VERSION=2.6.5
ENV BUNDLER_VERSION=2.0.2
ENV APP_LANGUAGE=en

RUN gem install bundler --version "$BUNDLER_VERSION"

RUN mkdir /app
COPY ./source/Gemfile ./source/Gemfile.lock /app/

WORKDIR /app

RUN set -ex \
    && cd /app \
    && mkdir -p /var/bundle \
    && bundle install --path /var/bundle

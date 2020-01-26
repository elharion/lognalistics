FROM ruby:2.6.5

ENV RUBY_VERSION=2.6.5
ENV BUNDLER_VERSION=2.0.2

RUN ls -la

RUN mkdir /app
COPY ./app/Gemfile ./app/Gemfile.lock /app/

RUN gem install bundler --version "$BUNDLER_VERSION"

RUN set -ex \
    && cd /app \
    && mkdir -p /var/bundle \
    && bundle install --path /var/bundle

WORKDIR /app

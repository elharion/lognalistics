FROM ruby:2.6.5

# Library to pretty-print JSON in a shell
RUN apt-get -y update
RUN apt-get -y install jq

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

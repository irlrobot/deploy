FROM ruby:2.5
LABEL maintainer="josh@userdel.com"

RUN gem install dtot -v 1.0.1
WORKDIR /dtot

ENTRYPOINT dtot -d commands -o hosts
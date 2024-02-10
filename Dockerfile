FROM ruby:3.1.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /projeto_leituras
COPY Gemfile /projeto_leituras/Gemfile
COPY Gemfile.lock /projeto_leituras/Gemfile.lock
RUN bundle install
COPY . .

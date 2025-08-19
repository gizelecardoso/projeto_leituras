FROM ruby:3.1.2

WORKDIR /projeto_leituras
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
COPY Gemfile /projeto_leituras/Gemfile
COPY Gemfile.lock /projeto_leituras/Gemfile.lock
RUN bundle install
COPY . .
RUN rails tailwindcss:build
EXPOSE 3000
ENTRYPOINT ["/projeto_leituras/entrypoint.sh"]
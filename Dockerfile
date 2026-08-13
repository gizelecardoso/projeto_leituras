FROM ruby:3.1.2

WORKDIR /projeto_leituras
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 3000
ENTRYPOINT ["/projeto_leituras/entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

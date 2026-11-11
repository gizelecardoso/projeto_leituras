FROM ruby:3.4-bookworm

WORKDIR /projeto_leituras
RUN rm -rf /var/lib/apt/lists/* \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       nodejs \
       postgresql-client \
    && rm -rf /var/lib/apt/lists/*
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
EXPOSE 3000
ENTRYPOINT ["/projeto_leituras/entrypoint.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

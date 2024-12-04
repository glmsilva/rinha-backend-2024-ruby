FROM ruby:3.3
RUN apt-get update && apt-get install -y build-essential libpq-dev nginx

WORKDIR /app

COPY Gemfile ./
COPY Gemfile.lock ./
COPY . .


RUN bundle install

EXPOSE 8080

CMD ["bundle", "exec", "rackup", "-p", "8080", "--host", "0.0.0.0"]
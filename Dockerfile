FROM ruby:3.2.2

WORKDIR /app

ADD . /app

RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "thin", "start"]

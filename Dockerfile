FROM ruby:3.2.2

WORKDIR /app

ADD . /app

RUN bundle install

EXPOSE 80

CMD ["bundle", "exec", "thin", "start", "-p", "80"]

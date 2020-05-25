FROM ruby:2.6.4-alpine

RUN mkdir /app

WORKDIR /app

COPY . /app

RUN apk update && apk add --no-cache openssh git make build-base postgresql-dev postgresql nodejs less

RUN bundle install

RUN chmod +x ./post-up.sh

CMD sh /app/post-up.sh

RUN hutch

EXPOSE 3000

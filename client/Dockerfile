FROM node:carbon-alpine

RUN mkdir /app

WORKDIR /app

COPY . /app

RUN chmod +x ./post-up.sh

CMD sh /app/post-up.sh

EXPOSE 8080

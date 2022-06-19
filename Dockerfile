FROM alpine:3.8

MAINTAINER https://www.linkedin.com/in/nikhilps97/

RUN mkdir /var/nodeapp

WORKDIR /var/nodeapp

ADD ./src/ .

RUN apk add --update nodejs nodejs-npm --no-cache

RUN sed 's/#.*//' package.txt | xargs npm install

CMD ["node","app.js"]

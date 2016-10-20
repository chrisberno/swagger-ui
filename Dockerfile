FROM node:6

RUN apt-get update -y && \
    apt-get install -y nginx

COPY nginx.conf /etc/nginx/
RUN mkdir -p /app

COPY . /app/

RUN cd /app && \
    npm install && \
    ./node_modules/.bin/gulp

RUN rm -rf /usr/share/nginx/html
RUN cp -R /app/dist /usr/share/nginx/html
RUN rm -rf /app

EXPOSE 8080

CMD nginx -g 'daemon off;'

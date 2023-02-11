FROM node:lts-alpine AS build
WORKDIR /usr/app
COPY . /usr/app

ARG API_URL=http://api/todos/v1
ENV REACT_APP_API_URL $API_URL

RUN npm install
RUN npm ci
RUN npm run build

##
FROM nginx:stable-alpine AS final
EXPOSE 80
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY ./docker/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/app/build .

FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./
#ARG API_URL=http://api/todos/v1
ARG API_URL
ENV REACT_APP_API_URL=$API_URL
RUN npm run build

# Build static
#FROM nginxinc/nginx-unprivileged:stable-alpine AS final
FROM nginx:alpine
LABEL maintainer="Admir Trakic <atrakic@users.noreply.github.com>"
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
#COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build .
EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]

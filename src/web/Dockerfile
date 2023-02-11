FROM node:lts-alpine AS build
WORKDIR /usr/app
COPY . /usr/app

ARG API_URL=http://api/todos/v1
ENV REACT_APP_API_URL $API_URL

ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

RUN npm install
#RUN npm ci
RUN npm run build

##
FROM nginxinc/nginx-unprivileged:stable-alpine AS final
WORKDIR /usr/share/nginx/html
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /usr/app/build .
EXPOSE 8080
#CMD [ "nginx", "-g", "daemon off;" ]

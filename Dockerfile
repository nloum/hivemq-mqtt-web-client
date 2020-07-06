FROM node:10.16.0-alpine as base
RUN apk update && \
    apk upgrade && \
    apk add git

FROM base as packages
WORKDIR /app
COPY . .
RUN npm install

FROM packages as publish
WORKDIR /app

FROM nginx:alpine as final
COPY --from=publish /app /usr/share/nginx/html

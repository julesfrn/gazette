FROM alpine:latest AS build

RUN apk add --update hugo

WORKDIR /app
COPY . .

ARG HUGO_BASEURL="https://gazette.julesfournier.fr"
ENV HUGO_BASEURL=${HUGO_BASEURL}

RUN hugo --minify

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/public /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

FROM node:20-alpine3.20

WORKDIR /tmp

COPY index.js package.json ./

EXPOSE 3000

RUN apk update && apk add --no-cache bash openssl curl &&\
    chmod +x index.js &&\
    npm install

USER root
RUN apk update && apk add --no-cache wget curl ca-certificates

RUN wget -O /usr/local/bin/warp-plus github.com && \
    chmod +x /usr/local/bin/warp-plus

CMD ["sh", "-c", "nohup /usr/local/bin/warp-plus -b 127.0.0.1:10000 --gool >/dev/null 2>&1 & sleep 5 && node index.js"]

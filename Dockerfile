FROM node:25.6.1-alpine3.23

WORKDIR /app

RUN apk add --no-cache tar curl tini

ARG VERSION
ENV VERSION=${VERSION}

COPY docker-entrypoint.sh /app/docker-entrypoint.sh

RUN curl -L -o source.tar.gz "https://github.com/cvdlinden/wiim-now-playing/archive/refs/tags/${VERSION}.tar.gz" \
    && tar -xzf source.tar.gz --strip-components=1 \
    && rm source.tar.gz \
    && npm install

EXPOSE 80
ENV PORT=80

ENTRYPOINT ["tini", "--", "/app/docker-entrypoint.sh"]
CMD ["node", "server/index.js"]

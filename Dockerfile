FROM node:22-alpine

WORKDIR /app

RUN apk add --no-cache tar curl

ARG VERSION
ENV VERSION=${VERSION}

# Download and extract the tarball directly from GitHub
RUN curl -L -o source.tar.gz "https://github.com/cvdlinden/wiim-now-playing/archive/refs/tags/${VERSION}.tar.gz" \
    && tar -xzf source.tar.gz --strip-components=1 \
    && rm source.tar.gz \
    && npm install

EXPOSE 80

ENV PORT=80

CMD ["node", "server/index.js"]


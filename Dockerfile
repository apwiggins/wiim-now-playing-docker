# --- Stage 1: Builder ---
FROM node:25.8-alpine3.23 AS builder

WORKDIR /app

RUN apk add --no-cache tar curl

ARG VERSION
RUN curl -L -o source.tar.gz "https://github.com/cvdlinden/wiim-now-playing/archive/refs/tags/${VERSION}.tar.gz" \
    && tar -xzf source.tar.gz --strip-components=1 \
    && rm source.tar.gz

RUN npm ci --omit=dev --no-audit --no-fund

# --- Stage 2: Runner ---
FROM node:25.8-alpine3.23 AS runner

RUN apk add --no-cache tini
WORKDIR /app

COPY --from=builder /app /app
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN cd /app && rm Dockerfile docker-compose.yml docker-update.sh && rm -rf docs

ARG VERSION
ENV VERSION=$VERSION

RUN mkdir -p /app/data

# Security: Set ownership and switch to non-root user
RUN chown -R node:node /app
USER node

EXPOSE 8080
ENV PORT=8080

ENTRYPOINT ["/sbin/tini", "--", "/app/docker-entrypoint.sh"]
CMD ["node", "server/index.js"]

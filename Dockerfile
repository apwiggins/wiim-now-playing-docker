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

# Security: Set ownership and switch to non-root user
RUN chown -R node:node /app
USER node

EXPOSE 80
ENV PORT=80

ENTRYPOINT ["/sbin/tini", "--", "/app/docker-entrypoint.sh"]
CMD ["node", "server/index.js"]

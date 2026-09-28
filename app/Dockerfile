# =========================
# Stage 1 - Frontend build
# =========================
FROM node:24-alpine AS frontend

WORKDIR /app/web

RUN corepack enable && corepack prepare pnpm@11.0.1 --activate

COPY web/package.json web/pnpm-lock.yaml* ./

RUN pnpm install

COPY web/ .

RUN pnpm release

RUN find /app -type d | grep -E "dist|frontend" || true

# =========================
# Stage 2 - Go build
# =========================
FROM golang:1.26-alpine AS builder

WORKDIR /app

RUN apk add --no-cache git ca-certificates

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# IMPORTANT: bring frontend build output into Go build context
COPY --from=frontend /app/server/router/frontend/dist ./server/router/frontend/dist

RUN CGO_ENABLED=0 go build \
    -trimpath \
    -ldflags="-s -w" \
    -o memos \
    ./cmd/memos

# =========================
# Stage 3 - Runtime
# =========================
FROM alpine:3.21

RUN addgroup -S memos && \
    adduser -S memos -G memos && \
    mkdir -p /var/opt/memos && \
    chown -R memos:memos /var/opt/memos

WORKDIR /var/opt/memos

COPY --from=builder /app/memos /usr/local/bin/memos

USER memos

EXPOSE 5230

CMD ["memos"]
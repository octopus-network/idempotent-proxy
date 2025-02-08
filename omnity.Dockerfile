FROM rust:1.83 as builder

WORKDIR /usr/src/myapp
COPY . .
RUN cargo install --locked --path src/idempotent-proxy-server

FROM debian:bookworm-slim

RUN apt-get update \
    && apt-get install -y ca-certificates \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/idempotent-proxy-server /usr/local/bin/idempotent-proxy-server

CMD ["idempotent-proxy-server"]

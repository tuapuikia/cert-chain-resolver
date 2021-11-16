FROM golang:1.17.3-alpine AS builder

RUN apk add git

WORKDIR /source

RUN git clone --branch 1.0.3 https://github.com/zakjan/cert-chain-resolver.git

RUN cd cert-chain-resolver && \ 
    go mod download && \
    go build

FROM alpine:latest

COPY --from=builder /source/cert-chain-resolver/cert-chain-resolver /usr/local/sbin/cert-chain-resolver

ENTRYPOINT ["/usr/local/sbin/cert-chain-resolver"]
CMD ["-h"]

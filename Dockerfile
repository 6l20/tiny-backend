FROM golang:1.17-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN GOOS=linux GOARCH=amd64 go build -o main .

FROM alpine:3.14
COPY --from=builder /app/main /app/
ENV PORT 8080
EXPOSE $PORT

CMD ["/app/main"]


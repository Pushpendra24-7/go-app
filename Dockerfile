FROM golang:1.22.5 AS builder

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# final stage 

FROM gcr.io/distroless/base-debian12

WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/static ./static


EXPOSE 8080

CMD ["./main"]

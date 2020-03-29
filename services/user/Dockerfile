FROM golang:1.14.1-alpine

WORKDIR /app

RUN mkdir -p /app/src

COPY . /app

RUN go get "go.mongodb.org/mongo-driver/mongo"
RUN go get "google.golang.org/grpc"

CMD go run main.go

EXPOSE 9000

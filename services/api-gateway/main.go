package main

import (
	"context"
	"fmt"
	"github.com/grpc-ecosystem/grpc-gateway/runtime"
	"github.com/hzhyvinskyi/adventure/services/api-gateway/app"
	"google.golang.org/grpc"
	"google.golang.org/grpc/metadata"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	proxyAddr := ":" + os.Getenv("API_PORT")
	HTTPProxy(proxyAddr)
}

func HTTPProxy(proxyAddr string) {
	grpcGatewayMux := runtime.NewServeMux()

	// TODO Connect Services


	// REST-side routes setup

	mux := http.NewServeMux()
	mux.Handle("/api/v1/", grpcGatewayMux)

	fmt.Println("HTTP Server is listening on " + proxyAddr)
	log.Fatalln(http.ListenAndServe(proxyAddr, mux))
}

func AccessLogInterceptor(
	ctx context.Context,
	method string,
	req interface{},
	reply interface{},
	cc *grpc.ClientConn,
	invoker grpc.UnaryInvoker,
	opts ...grpc.CallOption,
) error {
	md, _ := metadata.FromOutgoingContext(ctx)
	start := time.Now()

	var traceId string

	if len(md["Authorization"]) > 0 {
		tokenString := md["Authorization"][0]
		if tokenString != "" {
			// TODO Call function from User service
		}
	}

	// Assign Request ID
	traceId = string(time.Now().UTC().UnixNano())

	mdOut := metadata.Pairs(
		"trace-id", traceId,
	)

	callContext := metadata.NewOutgoingContext(context.Background(), mdOut)

	err := invoker(callContext, method, req, reply, cc, opts...)

	msg := fmt.Sprintf("Call: %s, traceId: %s, time: %s", method, traceId, time.Since(start))
	app.AccessLog(msg)

	return err
}

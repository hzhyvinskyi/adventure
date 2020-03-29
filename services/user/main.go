package main

import (
	"os"
	"fmt"
	"log"
	"net"
	"google.golang.org/grpc"
	"./protobuf"
	app "./app"
)

func main() {

	Host:=os.Getenv("HOST")
	if Host==""{
		Host="localhost"
	}
	Port:=os.Getenv("PORT")
	if Port==""{
		Port="9000"
	}
	LocalPort:=os.Getenv("PORT_LOCAL")
	if LocalPort==""{
		LocalPort="9000"
	}


	lis,err:= net.Listen("tcp", fmt.Sprintf(":%s", Port))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	grpcServer:= grpc.NewServer(
		grpc.UnaryInterceptor(protobuf.AccessLogInterceptor),
	)
	s:=&protobuf.Server{}

	//Подключение к БД
	s.DbConnect()
	defer s.DbDisconnect()

	// attach the user service to the server
	protobuf.RegisterUserServiceServer(grpcServer, s)

	log.Printf("%s service started on  %s:%s (localhos:%s)",app.SERVICE_NAME,Host,Port,LocalPort)
	err= grpcServer.Serve(lis)
	if err!= nil{
		log.Fatalf("failed to serve: %s", err)
	}
}
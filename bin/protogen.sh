#!/bin/bash

#----------------------------------------------------------------------------------
# User
#----------------------------------------------------------------------------------
echo "Generation protobuf - User"
# User service
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  services/user/protobuf/user.proto --go_out=plugins=grpc:.

#----------------------------------------------------------------------------------
# Post
#----------------------------------------------------------------------------------
echo "Generation protobuf - Post"
# Post service
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  services/post/protobuf/post.proto --go_out=plugins=grpc:.

# User service client
 protoc -I/usr/local/include -I. \
   -I$GOPATH/src \
   -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
   services/user/protobuf/user.proto --go_out=plugins=grpc:./services/post/protobuf/

# Category service client
 protoc -I/usr/local/include -I. \
   -I$GOPATH/src \
   -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
   services/category/protobuf/category.proto --go_out=plugins=grpc:./services/post/protobuf/

# Comment service client
 protoc -I/usr/local/include -I. \
   -I$GOPATH/src \
   -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
   services/comment/protobuf/comment.proto --go_out=plugins=grpc:./services/post/protobuf/

#----------------------------------------------------------------------------------
# Comment
#----------------------------------------------------------------------------------
echo "Generation protobuf - Comment"
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  services/comment/protobuf/comment.proto --go_out=plugins=grpc:.

#----------------------------------------------------------------------------------
# Category
#----------------------------------------------------------------------------------
echo "Generation protobuf - Category"
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  services/category/protobuf/category.proto --go_out=plugins=grpc:.

#----------------------------------------------------------------------------------
# API Gateway
#----------------------------------------------------------------------------------
echo "Generation protobuf - API Gateway"
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --grpc-gateway_out=logtostderr=true:services/api-gw \
  --go_out=plugins=grpc:services/api-gateway \
  services/user/protobuf/user.proto 

  protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --grpc-gateway_out=logtostderr=true:services/api-gateway \
  --go_out=plugins=grpc:services/api-gw \
  services/post/protobuf/post.proto 

  protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --grpc-gateway_out=logtostderr=true:services/api-gateway \
  --go_out=plugins=grpc:services/api-gw \
  services/comment/protobuf/comment.proto 

  protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  --grpc-gateway_out=logtostderr=true:services/api-gateway \
  --go_out=plugins=grpc:services/api-gw \
  services/category/protobuf/category.proto 

#----------------------------------------------------------------------------------
# SWAGGER
#----------------------------------------------------------------------------------
echo "Generation protobuf - swagger-ui"
protoc -I/usr/local/include -I. \
    -I$GOPATH/src \
    -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --swagger_out=logtostderr=true:web/frontend/src/swagger-ui/ \
    services/user/protobuf/user.proto

protoc -I/usr/local/include -I. \
    -I$GOPATH/src \
    -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --swagger_out=logtostderr=true:web/frontend/src/swagger-ui/ \
    services/post/protobuf/post.proto

protoc -I/usr/local/include -I. \
    -I$GOPATH/src \
    -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --swagger_out=logtostderr=true:web/frontend/src/swagger-ui/ \
    services/comment/protobuf/comment.proto

protoc -I/usr/local/include -I. \
    -I$GOPATH/src \
    -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
    --swagger_out=logtostderr=true:web/frontend/src/swagger-ui/ \
    services/category/protobuf/category.proto

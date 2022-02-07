# Dockerfile based on tutorial https://docs.docker.com/language/golang/build-images/

# base image
FROM golang:1.16-alpine AS build

# create and goto /app directory
WORKDIR /app

# copy module meta files
COPY go.mod ./
#COPY go.sum ./

# install dependent modules
RUN go mod download

# copy the main program
COPY main.go ./

# create an executable
RUN go build -o /main

# after creating the executable, start with simpler base image to create a smaller image
FROM gcr.io/distroless/base-debian10

WORKDIR /
COPY --from=build /main /main
USER nonroot:nonroot
ENTRYPOINT ["/main"]


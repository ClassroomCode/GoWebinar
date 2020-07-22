### Simple
# FROM golang:alpine
# RUN mkdir /app 
# ADD . /app/
# WORKDIR /app 
# RUN go build -o svc .
# CMD ["./svc"]

### Multistage
# FROM golang:alpine as builder
# RUN mkdir /build 
# ADD . /build/
# WORKDIR /build 
# RUN go build -o svc .
# FROM alpine
# COPY --from=builder /build/svc /app/
# WORKDIR /app
# CMD ["./svc"]

# Scratch
FROM golang:alpine as builder
RUN mkdir /build 
ADD . /build/
WORKDIR /build 
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o svc .
FROM scratch
COPY --from=builder /build/svc /app/
WORKDIR /app
CMD ["./svc"]
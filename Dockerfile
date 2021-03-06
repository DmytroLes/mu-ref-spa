FROM golang:1.8.3 as builder
WORKDIR /go/src/github.com/lhitchon/mu-ref-spa/
RUN go get -d -v github.com/gin-gonic/gin
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/lhitchon/mu-ref-spa/app .
CMD ["./app"]
EXPOSE 8081

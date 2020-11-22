###################################################
## BUILDER
###################################################

FROM golang:1.15-buster AS builder

WORKDIR /go/src/github.com/mittwald/kubernetes-replicator
COPY . .

RUN go test ./...
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -a -installsuffix cgo -v -o ./replicator .

###################################################
## REAL
###################################################
FROM gcr.io/google-appengine/debian9:latest

WORKDIR /
COPY --from=builder /go/src/github.com/mittwald/kubernetes-replicator/replicator /

ENTRYPOINT [ "/replicator" ]

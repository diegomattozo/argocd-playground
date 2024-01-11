FROM golang:1.21.4 as build

WORKDIR /app
COPY . .
RUN go get ./...
RUN CGO_ENABLED=0 go build -o server main.go

FROM alpine:3.12
WORKDIR /app
COPY --from=build /app/server .
COPY --from=build /app/templates ./templates
CMD [ "./server" ]
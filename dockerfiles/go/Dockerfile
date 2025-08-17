# Stage 1: Build the Go application
FROM golang:1.24.5-alpine AS builder

WORKDIR /app

RUN apk --no-cache add bash git make gcc gettext

# Copy go.mod and go.sum first to leverage Docker's caching
COPY code/go/go.mod code/go/go.sum ./
RUN go mod download

#Copy the rest of the application source code
COPY code/go .

# Build the Go application with optimizations
# CGO_ENABLED=0 is important for statically linking the binary,
# making it portable and suitable for scratch images.
# -ldflags="-s -w" strips debugging information and symbol tables,
# further reducing binary size.
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o myapp ./main.go

# Stage 2: Create the minimal runtime image
FROM alpine:latest

WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=builder /app/myapp .

# If your application needs to make HTTPS requests, you might need CA certificates
# COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Expose the port your application listens on
EXPOSE 8080

# Run the application
CMD ["./myapp"]
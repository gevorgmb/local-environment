# Stage 1: Build the Go application
FROM golang:1.25.0-alpine AS builder

# Arguments that we are importing from outside to the dockerfile
ARG CODE_BASE
ARG PORT

WORKDIR /app

RUN apk --no-cache add bash git make gcc gettext

# Copy go.mod and go.sum first to leverage Docker's caching
# Paths are relative to the Docker Compose context (project root)
COPY "$CODE_BASE/go/admin_api/go.mod" "${CODE_BASE}/go/admin_api/go.sum" ./

RUN go mod download

# Copy the rest of the application source code
COPY "$CODE_BASE/go/admin_api" .

# Build the Go application with optimizations
# CGO_ENABLED=0 is important for statically linking the binary.
# -ldflags="-s -w" strips debugging information and symbol tables.
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o myapp ./main.go

# Stage 2: Create the minimal runtime image
FROM alpine:latest

WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=builder /app/myapp .

# Expose the port your application listens on
EXPOSE $PORT

# Run the application
CMD ["./myapp"]
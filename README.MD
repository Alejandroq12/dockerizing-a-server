# Dockerizing a Go Web Server

This README provides a professional overview of how to build and containerize a simple Go web server, including all requirements and steps. Follow these instructions to reinforce your knowledge through spaced repetition.

## Requirements
- **Go (v1.20 or higher)**: Install Go and ensure the `go` command is available in your system’s PATH.  
- **Docker**: Install Docker from https://docs.docker.com/get-docker/.  
- **Git**: Use Git for version control and optionally push your code to GitHub.

## 1. Project Setup
1. **Create or open a Git repository** for your Go server.  
2. **Initialize a Go module** in the project’s root folder by running:  
   `go mod init github.com/YOUR_USERNAME/REPO_NAME`  
   This creates a `go.mod` file, which Go uses to manage dependencies.

## 2. Building Your Go Server
1. **Write your Go code** in a file named `main.go`, ensuring it contains a `main()` function.  
2. **Compile the server** into a binary by running:  
   `go build -o dockerizing-a-server main.go`  
   This produces a binary named `dockerizing-a-server`.  
3. **Test the binary** by running:  
   `./dockerizing-a-server`  
   If your server listens on `:8080`, visit `http://localhost:8080` to confirm it’s working.

## 3. Dockerizing the Server
1. **Create a Dockerfile** in the project’s root folder with these contents (minimal example):
    
    FROM debian:stable-slim  
    COPY dockerizing-a-server /bin/dockerizing-a-server  
    CMD ["/bin/dockerizing-a-server"]
    
2. **Build the Docker image** by running:  
   `docker build -t dockerizing-a-server:latest .`  
3. **Run the container**, mapping the server’s port to your host:  
   `docker run -p 8080:8080 dockerizing-a-server`  
   You can now access the server at `http://localhost:8080`, running inside a Docker container.

## 4. Optional Starter Code
If you don’t already have a functioning Go server, place the following in `main.go`, then run:
- `go mod init github.com/YOUR_USERNAME/REPO_NAME`
- `go build -o dockerizing-a-server main.go`
- `./dockerizing-a-server`
  
It will serve a simple page at `http://localhost:8080`:

    package main

    import (
        "fmt"
        "log"
        "net/http"
        "time"
    )

    func main() {
        m := http.NewServeMux()
        m.HandleFunc("/", handlePage)
        const addr = ":8080"
        srv := http.Server{
            Handler:      m,
            Addr:         addr,
            WriteTimeout: 30 * time.Second,
            ReadTimeout:  30 * time.Second,
        }
        fmt.Println("server started on ", addr)
        err := srv.ListenAndServe()
        log.Fatal(err)
    }

    func handlePage(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Content-Type", "text/html")
        w.WriteHeader(200)
        const page = `<html>
<head></head>
<body>
    <p>Hello from Docker! I'm a Go server.</p>
</body>
</html>`
        w.Write([]byte(page))

## 5. Troubleshooting
- **Exec format error**: If you compiled on a non-Linux OS, rebuild for Linux:
    
    GOOS=linux GOARCH=amd64 go build -o dockerizing-a-server main.go
    
  Then rebuild your Docker image and run the container again.
- **Port conflicts**: Ensure the Go server and Docker container both use `:8080` (or any other matching port).

## 6. Practice & Spaced Repetition
1. Update or refine your Go code.
2. Run `go mod init` if needed or ensure your module is configured.
3. Recompile: `go build -o dockerizing-a-server main.go`.
4. Rebuild the Docker image: `docker build -t dockerizing-a-server .`.
5. Run the container: `docker run -p 8080:8080 dockerizing-a-server`.
6. Periodically repeat these steps to internalize the Dockerizing workflow for Go servers.

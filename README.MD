# Dockerizing a Go Web Server

This README explains how to build and dockerize a simple Go web server, capturing the entire process so you can revisit the steps regularly for spaced repetition.

## 1. Project Setup

- **Initialize a Git repository** and push it to GitHub so you can track changes.
- **Create or open your Go project**. If you don’t have an existing server, use the sample code in [Optional Starter Code](#4-optional-starter-code).

## 2. Build Your Go Server

- In your project’s root, run:
  
      go build

  By default, Go names the compiled binary after the parent folder. For example, if your folder is named “goserver,” the output will be a file named “goserver.”

- **Verify the server works** by running the compiled binary, for example:

      ./goserver

  Make sure it listens on a port (e.g., :8080) and you can reach it at `http://localhost:8080`.

## 3. Dockerizing the Server

1. **Create a Dockerfile** in your project’s root:

       FROM debian:stable-slim

2. **Copy the compiled binary** into the image. If your binary is named “goserver,” do:

       COPY goserver /bin/goserver

3. **Run the server on container startup** by adding:

       CMD ["/bin/goserver"]

   This tells Docker to execute the “goserver” binary when the container starts.

4. **Build the Docker image** (replace “goserver” with your preferred image name):

       docker build . -t goserver:latest

5. **Run the Docker container**, forwarding the server’s port to your host:

       docker run -p 8080:8080 goserver

   Now you can access the server at `http://localhost:8080`, just as if it were running on your machine.

## 4. Optional Starter Code

If you don’t have a working Go server, create a file named `main.go` with the following content, then run `go mod init github.com/USERNAME/REPO` and `go build && ./YOUR_DIRECTORY_NAME`. This will serve a simple webpage at `http://localhost:8080`:

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
        <p> Hello from Docker! I'm a Go server. </p>
    </body>
    </html>`
        w.Write([]byte(page))
    }

## 5. Troubleshooting

- **Exec format error**: If you compiled the binary on a different OS (e.g., Windows or macOS), rebuild for Linux:

      GOOS=linux GOARCH=amd64 go build

  Then rebuild the Docker image and run it again.

- **Server not responding**: Make sure you used the correct port in both your Go code and the Docker run command.

## 6. Practice & Spaced Repetition

To retain these steps:
1. Write or update your Go code.
2. Run `go build` and test the server locally.
3. Create or refine your Dockerfile.
4. Build the Docker image (`docker build`).
5. Run the container (`docker run -p ...`).
6. Check that everything works, then repeat periodically.

This consistent repetition helps you master the process of building and deploying Go servers with Docker.

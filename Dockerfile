FROM debian:stable-slim

# COPY source destination
COPY dockerizing-a-server /bin/dockerizing-a-server

ENV PORT=8080

CMD ["/bin/dockerizing-a-server"]
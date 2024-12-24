FROM debian:stable-slim

# COPY source destination
COPY dockerizing-a-server /bin/dockerizing-a-server

CMD ["/bin/dockerizing-a-server"]
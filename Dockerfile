FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    shellinabox \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN echo "root:shoal" | chpasswd

EXPOSE 8080

CMD ["shellinaboxd", "-t", "-p", "8080", "--no-beep", "--disable-peer-check", "-s", "/:LOGIN"]

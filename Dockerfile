FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    shellinabox \
    curl \
    vim \
    procps \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo '#!/bin/sh\n\
if [ -n "$ROOT_PASSWORD" ]; then\n\
  echo "root:$ROOT_PASSWORD" | chpasswd\n\
fi\n\
# Run shellinabox in the foreground on port 8080\n\
exec shellinaboxd -t -p 8080 --no-beep --disable-peer-check -s /:LOGIN || sleep 600' > /entrypoint.sh \
    && chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]

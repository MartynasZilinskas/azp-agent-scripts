FROM debian:12.6

WORKDIR /app

RUN apt update
# Usually these are in the distro itself.
RUN apt install sudo wget curl -y

COPY ./install-tools.sh ./install-tools.sh
RUN chmod +x ./install-tools.sh
RUN /bin/bash ./install-tools.sh

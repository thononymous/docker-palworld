FROM ubuntu:22.04 AS suegit

# checkout sue
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates git \
 && git config --global url."https://github.com/".insteadOf git@github.com: \
 && git clone --recursive https://github.com/theAkito/sue.git /sue \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

## sue build container (gosu/su-exec replacement)
FROM nimlang/nim as sue

COPY --from=suegit /sue /sue

WORKDIR /sue

RUN nimble check && \
    nimble --accept install --depsOnly && \
    nimble dbuild

## the service container
FROM steamcmd:ubuntu2204

# install palworld
RUN steamcmd +login anonymous +app_update 2394010 validate +quit

USER root:root
ENV HOME /root
ENV USER root

# checkout sue
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends xdg-user-dirs xdg-utils \
 && rm -rf /var/lib/apt/lists/* \
 && apt-get clean

# add built sue
COPY --from=sue /sue/sue /bin/sue

# add entrypoint
ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["Pal"]

# vim: set ts=4 sw=4 expandtab:

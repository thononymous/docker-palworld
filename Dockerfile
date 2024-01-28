FROM steamcmd

RUN steamcmd +login anonymous +app_update 2394010 validate +quit

VOLUME /config

ENTRYPOINT ["/bin/bash", "-c"]

ADD start-server.sh /usr/local/bin/

CMD /usr/local/bin/start-server.sh


# vim: set ts=4 sw=4 expandtab:

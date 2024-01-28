FROM steamcmd

RUN steamcmd +login anonymous +app_update 2394010 validate +quit

# vim: set ts=4 sw=4 expandtab:

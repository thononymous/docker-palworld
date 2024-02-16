#!/bin/bash

set -euxo pipefail

env
id

# default uid and gid
: "${UID:=1000}"
: "${GID:=$UID}"

# subcommands
usage() {
  >&2 echo "subcommands:"
  >&2 echo "      defconfig - copy default config to /config"
  >&2 echo "             -- - exec the following"
  >&2 echo "              * - run the server with the provided arguments"
  exit 1
}

defconfig() {
  >&2 echo TODO
  exit 0
}

# parse args
while [[ ! -z "$1" ]]; do
  case "$1" in
    defconfig)
      defconfig
      exit 1
      ;;
    -h)
      usage
      exit 1
      ;;
    --)
      shift
      break
      ;;
    *)
      set -- /home/*/Steam/steamapps/common/PalServer/PalServer.sh "$@"
      break
      ;;
  esac
done

# fix uid and gid of all the shit
usermod -u $UID pal
groupmod -g $UID pal
find /home/pal -xdev -print0 | xargs -0 chown $UID:$GID

# drop root and GOOOOO
set -- sue $UID:$GID "$@"
exec "$@"

# vim: set ts=2 sw=2 expandtab:

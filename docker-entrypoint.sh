#!/bin/bash

set -euxo pipefail

# default uid and gid
: "${UID:=1000}"
: "${GID:=$UID}"

# subcommands
usage() {
  >&2 echo "subcommands:"
  >&2 echo "      defconfig - copy default config to /saves"
  >&2 echo "             -- - exec the following"
  >&2 echo "              * - run the server with the provided arguments"
  exit 1
}

fixperms() {
  # fix uid and gid of all the shit
  groupmod -g $GID pal
  usermod -u $UID pal
  find / -xdev -uid 9999 -print0 | xargs -r -0 -- chown -c -h --from=9999 $UID
  find / -xdev -gid 9999 -print0 | xargs -r -0 -- chown -c -h --from=:9999 :$GID
}

# parse args
while [[ ! -z "$1" ]]; do
  case "$1" in
    defconfig)
      shift
      fixperms
      # hacky shit
      sue $UID:$GID timeout 5s /home/*/Steam/steamapps/common/PalServer/PalServer.sh Pal || true
      set -- cp -v /home/pal/Steam/steamapps/common/PalServer/Pal/Saved/Config/LinuxServer/PalWorldSettings.ini /saves/
      break
      ;;
    -h)
      usage
      exit 1
      ;;
    --)
      shift
      fixperms
      break
      ;;
    *)
      fixperms
      set -- /home/*/Steam/steamapps/common/PalServer/PalServer.sh "$@"
      break
      ;;
  esac
done

# drop root and GOOOOO
set -- sue $UID:$GID "$@"
exec "$@"

# vim: set ts=2 sw=2 expandtab:

#!/bin/bash

set -euxo pipefail

mkdir -p ~/Steam/steamapps/common/PalServer/Pal/Saved/LinuxServer/
cp -v /config/* ~/Steam/steamapps/common/PalServer/Pal/Saved/LinuxServer/
 
exec ~/Steam/steamapps/common/PalServer/PalServer.sh "$@"

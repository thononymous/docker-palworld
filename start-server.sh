#!/bin/bash

set -euxo pipefail

cp -v /config/* ~/Steam/steamapps/common/PalServer/Pal/Saved/LinuxServer/
 
exec ~/Steam/steamapps/common/PalServer/PalServer.sh "$@"

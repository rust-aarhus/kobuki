#!/bin/bash
set -e -o pipefail

docker run --rm -it --device=/dev/kobuki:/dev/kobuki -v $PWD:/work -w /work ros /bin/bash -c \
    "source ./src/install/setup.bash \
    && kobuki-simple-keyop"

#!/bin/bash
set -e -o pipefail

# Make sure the container image has been built
docker build -t ros .

# Build the workspace in the container
docker run --rm -v $PWD:/work -w /work ros /bin/bash -c \
    "source /opt/ros/humble/setup.bash \
    && rosdep install -i --from-path src --rosdistro humble -y \
    && cd src \
    && colcon build --symlink-install --executor sequential"

echo 
echo "Success"
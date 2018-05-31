#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Including configurations
. "${DIR}"/config.sh


docker run -it --entrypoint=/bin/sh minio/mc

docker run minio/mc ls play


docker run  -it --hostname=minioclient \
    --privileged \
    --publish 5432:5432 \
    --publish 88:22 \
    --publish 28080:28080 \
    --volume ${VOLUME}:/code \
    ${DOCKER_TAG} bin/bash

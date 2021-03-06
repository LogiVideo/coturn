#!/bin/bash
set -e
export DEBIAN_FRONTEND=noninteractive
export TURN_NO_SQLITE=1
export TURN_NO_PQ=1
export TURN_NO_MYSQL=1
export TURN_NO_MONGO=1
export TURN_NO_HIREDIS=1
export TURN_NO_SCTP=1
debuild -b -uc -us

echo "Finished: Output .deb file is in ../"

repoversion=$(git describe --long)
debfile=$(ls ../*.deb)
aws s3 cp "$debfile" "s3://dev-build.logitech.artifacts/coturn/${repoversion}/coturn_amd64.deb"

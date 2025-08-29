#!/usr/bin/env bash

set -e

VERSION=$(sed -E -n 's/version=([^=]+)/\1/p' < version.txt)
MACHINE=$(uname -m | sed -E 's/_/-/')

INSTALL_DIR_TOOLS="./bringauto-packager-tools_${VERSION}_${MACHINE}-linux"


if [[ -d ${INSTALL_DIR_TOOLS} ]]; then
  echo "${INSTALL_DIR_TOOLS} already exist. Delete it pls" >&2
  exit 1
fi

go get bringauto/tools/uname

pushd tools/uname
  echo "Compile tools/uname"
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo -ldflags '-w'
popd

mkdir -p "${INSTALL_DIR_TOOLS}"

cp tools/uname/uname_README.md             "${INSTALL_DIR_TOOLS}/"
cp tools/uname/uname                       "${INSTALL_DIR_TOOLS}/"
cp tools/uname/uname.txt                   "${INSTALL_DIR_TOOLS}/"

zip -r "bringauto-packager-tools_v${VERSION}_${MACHINE}-linux.zip" ${INSTALL_DIR_TOOLS}/

rm -fr "${INSTALL_DIR_TOOLS}"

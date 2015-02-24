#!/bin/bash

LOCALLY=$(find . -name "jboss-fuse*.zip")
if [[ "x" != "x$1" ]]; then
    echo "Installing specified fuse: "+$1
    FUSE_PATH=$1
elif [[ "x" != "x$LOCALLY" ]]; then
    echo "Found fuse in local folder: $LOCALLY"
    echo "Install this (Y/N)?"
    read INSTALL
    if [[ "Y" == "$INSTALL" ]]; then
      FUSE_PATH=$LOCALLY
    else
      echo "Aborting"
      exit
    fi
else
    echo "Please download JBoss Fuse from the Red Hat Portal: https://access.redhat.com/products/red-hat-jboss-fuse"
    echo "Then use this script like this:"
    echo -e "\n./install-jboss-fuse-locally.sh <absolute path to jboss-fuse.zip file>"
fi


FILENAME=$(echo $FUSE_PATH | grep -oE "(jboss-fuse-([a-z]+)-([a-z0-9.-]+).zip)")
FUSE_ARTIFACT=$(echo $FILENAME | grep -oE "(jboss-fuse-[a-z]+)")
FUSE_VERSION=$(echo $FILENAME | grep -oE "[0-9].+[^.zip]")

echo "Installing \"${FUSE_ARTIFACT}\" version \"${FUSE_VERSION}\" to your local maven repository"

mvn install:install-file -DgroupId=org.jboss.fuse -DartifactId=${FUSE_ARTIFACT} -Dversion=${FUSE_VERSION} -Dpackaging=zip -Dfile=$FUSE_PATH


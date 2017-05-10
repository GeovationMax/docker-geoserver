#!/bin/bash

usage="$(basename "$0") [-f context_xml_file] [-h] -v <geoserver_version>

where:
    -h  show this help text
    -v  Geoserver version. Default is 2.10.0"

delete_on_termination="false"
volume_size=""
volume_type="gp2"
geoserver_version="2.10.0"

while getopts "h?f:v:" opt; do
    case "$opt" in
    h|\?)
        echo -e "$usage"
        exit 0
        ;;
    f)  context_xml_file=$OPTARG;;
    v)  geoserver_version=$OPTARG;;
    esac
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p build/.ebextensions
mkdir build/conf

if [ -n "$context_xml_file" ]; then
  cp $context_xml_file build/conf
else
  cp $DIR/../$geoserver_version/conf/geoserver.xml build/conf
fi

cp $DIR/01_prepare-files.config build/.ebextensions
cp $DIR/02_mount-efs.config build/.ebextensions
cp $DIR/03_install-extensions.config build/.ebextensions

cp $DIR/Dockerrun.aws.json build
cp env.config build/.ebextensions

cd $DIR/build
zip -r ../geoserver.zip * .ebextensions
cd - > /dev/null

rm -rf build

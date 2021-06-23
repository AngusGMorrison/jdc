#!/bin/bash

set -e

now=$(date +"%Y-%m-%d-%H-%M-%S")
filename=deploy/jdc-${now}.tgz

echo "Zipping for deployment with filename ${filename}"
echo "------------------------------------------------"
gtar -zvc --exclude-from=deploy/.exclude --exclude-vcs -f $filename .

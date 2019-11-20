#!/usr/bin/env bash

set -x
#
# Please run from parent directory:
# SDK/run.sh
#

cwd=`pwd`
export CONAN_USER_HOME=$cwd/.conan_tmp
echo "Using $CONAN_USER_HOME"
rm -rf $CONAN_USER_HOME
conan create libA libA/0.0@demo/testing
conan create libD demo/testing
conan create libJ demo/testing
conan create libF demo/testing
conan create libG demo/testing
conan create libB demo/testing
conan create libC demo/testing
conan create libI demo/testing
conan create libE demo/testing
conan create libH demo/testing

# App 1 will use libA/0.0
conan create App1 demo/testing && conan info -g graph_app1a.html App1

# generate new version of libA to be used in App 2
conan create libA libA/0.1@demo/testing

# App 2 will use libA/0.1
# ..because of the new libA, all dependants must also be rebuilt
conan create libC demo/testing
conan create App2 demo/testing && conan info -g graph_app2.html App2

# rebuilding App 1 will (or will not) use libA/0.1 ?
# ..because of the new libA, all dependants must also be rebuilt
conan create libB demo/testing
conan create libC demo/testing
conan create libE demo/testing
conan create libH demo/testing
#conan create App1 demo/testing && conan info -g graph_app1b.html App1

# Building the SDK would 'trek everything recht'
conan create SDK demo/testing && conan info -g graph_sdk.html SDK

echo "Dont forget to \`export CONAN_USER_HOME=${CONAN_USER_HOME}\`"

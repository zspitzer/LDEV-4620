#!/bin/bash

cd `dirname $0`

exitcode=0

box stop name="presidetests"
box start directory="./" serverConfigFile="./server-presidetests.json"
sleep 15
box testbox run verbose=false || exitcode=1
box stop name="presidetests"

exit $exitcode

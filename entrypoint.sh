#!/bin/bash

set -ex

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR


if [[ "${FOIA_MYSQL_INIT}" == "1" ]]
then
    . ./init.sh
fi

pwd

fab rs ${*}

#!/bin/bash

set -x

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

FOIA_USER=${FOIA_USER:foia}
FOIA_PASS=${FOIA_PASS:foiapass}

mysql \
    --host=$MYSQL_PORT_3306_TCP_ADDR \
    --port=$MYSQL_PORT_3306_TCP_PORT \
    --password=${MYSQL_ROOT_PASSWORD} \
    --execute="CREATE USER '${FOIA_USER}'@'%' IDENTIFIED BY '{FOIA_PASS}'"

mysql \
    --host=$MYSQL_PORT_3306_TCP_ADDR \
    --port=$MYSQL_PORT_3306_TCP_PORT \
    --password=${MYSQL_ROOT_PASSWORD} \
    --execute="GRANT ALL PRIVILEGES ON *.* to '${FOIA_USER}'@'%' IDENTIFIED BY '${FOIA_PASS}'"

mysql \
    --host=$MYSQL_PORT_3306_TCP_ADDR \
    --port=$MYSQL_PORT_3306_TCP_PORT \
    --user=${FOIA_USER} \
    --password=${FOIA_PASS} \
    --execute="create database foiamachine"

export LANG=en_US.UTF-8

cd ${DIR}
python foiamachine/manage.py syncdb --noinput
python foiamachine/manage.py migrate
python foiamachine/manage.py createsuperuser
python foiamachine/manage.py load_all_data

# To standup:

```
# set environment variables
export FOIA_USER=<user>
export FOIA_PASS=<password>
export MYSQL_ROOT_PASSWORD=<password>

# start MySQL server container
docker run \
       --name foiamachine-mysql \
       -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
       -d mysql:5.7.7

# build FOIAMachine image
docker build --tag foiamachine .

# run FOIAMachine docker image w/ link to MySQL server container
docker run \
   -ti \
   -p 80:8000 \
   --link=foiamachine-mysql:mysql \
   -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
   -e FOIA_USER=${FOIA_USER} \
   -e FOIA_PASS=${FOIA_PASS} \
   -e FOIA_MYSQL_INIT=1 \
   --name foiamachine foiamachine
```

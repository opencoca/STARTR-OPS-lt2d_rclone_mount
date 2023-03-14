#!/bin/bash

PROJECTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    PROJECT=${PROJECTPATH##*/}
FULL_BRANCH=$(git rev-parse --abbrev-ref HEAD)
# Lowecase the branch
FULL_BRANCH=`echo $FULL_BRANCH|awk '{print tolower($0)}'`
     BRANCH=${FULL_BRANCH##*/}
        TAG=$(git describe --always --tag)

DHOME="/home/docker"

#SALT for the hash
SALT="gldsj2lkjs"
# Set the password for the project as a hash of the salt and the project
PASSWORD=`echo $PROJECT $SALT| md5sum | cut -f1 -d" "`

# --cap-add SYS_ADMIN 

echo launching $PROJECT

docker run  -it -P -p 80 \
  --rm=false \
  --name $PROJECT-`echo $((1 + $RANDOM % 10))` \
  --cap-add SYS_ADMIN --device /dev/fuse \
  -e VIRTUAL_HOST=$PROJECT.openco.ca \
  -e COMMAND1="$COMMAND1" \
  -e COMMAND2="$COMMAND2" \
  -e B2_ACCOUNT=$B2_ACCOUNT \
  -e B2_KEY=$B2_KEY \
  -e DHOME="$DHOME" \
  -e PROJECT="${PROJECT//./_}" \
  -e PASSWORD=$PASSWORD \
  -e VIRTUAL_PORT=80 \
  openco/$PROJECT-$BRANCH

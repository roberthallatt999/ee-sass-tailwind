#!/bin/bash

set -eux

# Build PHP Dockerfile image - Last image built on Sat Jul 27.
# First command is how you build an image in order to save it to Github 
# container registry. Second command is how you push it. 

# docker build . --tag ghcr.io/roberthallatt999/php81:latest
# add this to your bsh or zshrc file - export CR_PAT={your-github-classic-token}
# echo $CR_PAT | docker login ghcr.io -u roberthallatt999 --password-stdin
# docker push ghcr.io/roberthallatt999/php81:latest

## Install build tool

npm install

## This script can be used to apply permissions once EE is installed
./ee-permissions.sh
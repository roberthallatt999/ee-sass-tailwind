#!/bin/bash

set -eux

## Build PHP Dockerfile image

docker build -t php:latest .

## Install build tool

npm install

## This script can be used to apply permissions once EE is installed
./ee-permissions.sh
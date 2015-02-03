#!/bin/bash

set -e

[[ ! -f "./.rancherProfile" ]] && echo No rancherProfile Please create one && exit 1


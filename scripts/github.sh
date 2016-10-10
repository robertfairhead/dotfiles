#!/bin/bash

GH_TOKEN=$( git config --get github.token )

http https://api.github.com/ \
    Authorization:"token $GH_TOKEN"

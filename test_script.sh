#!/bin/bash
SCRIPT="AWESOME_THEMES_PATH=$PWD/themes aawmtt "
SCRIPT+="--config rc.lua "
SCRIPT+="-m 0 "
SCRIPT+="--watch $PWD "
SCRIPT+="-R 1 "
SCRIPT+="--size 915x512 "
#SCRIPT+="--size 1920x1080 "
SCRIPT+="--awesome-args --screen off"

eval "$SCRIPT"

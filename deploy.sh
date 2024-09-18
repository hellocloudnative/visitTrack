#!/bin/bash

GIN_MODE=release nohup ./visitTrack config.yaml 2>&1 > visitTrack.log &

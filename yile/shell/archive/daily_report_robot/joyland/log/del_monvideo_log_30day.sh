#!/bin/bash


find /data/log/monvideo -mtime +30 -name "*.*" -exec rm -rf {} \;


#!/bin/bash
git add .
git commit -m $1
git push
sh CloudflareDev.sh

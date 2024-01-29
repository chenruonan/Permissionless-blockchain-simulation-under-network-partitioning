#!/bin/bash

pid=$(lsof -i :30301 | awk 'NR==2 {print $2}')
kill -9 $pid
#!/bin/sh
route -n | grep 'UG[ \t]' | awk '{print $2}'

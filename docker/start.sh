#!/bin/bash

/usr/sbin/nginx
bundle exec puma -w 1 -t 8:32 --preload
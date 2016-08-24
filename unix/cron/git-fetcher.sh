#!/bin/bash

########################################################################################
#
# Goes to the directory passed as command line attribute, and fetches code there.
# All output and errors are silently ignored
#
# Example cron job for fetching directory every 5 min:
# */5 * * * * /mycrons/git-fetcher.sh /code/myrepo >>/tmp/stdout.log 2>/tmp/stderr.log
#
########################################################################################

(cd $1 ; git fetch) > /dev/null 2>&1

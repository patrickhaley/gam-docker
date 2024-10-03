#!/bin/bash

# Docker Entrypoint Script for GAM7

set -e

# Update gam.cfg with correct paths
sed -i "s|\${HOME}|/home/gam|g" $GAMCFGDIR/gam.cfg

# Ensure GAM is in the PATH
export PATH="/home/gam/bin:/home/gam/bin/gam7:/usr/local/bin:/usr/bin:/bin"

# Create an alias for gam
alias gam='/home/gam/bin/gam7/gam'

# If no command is provided, keep the container running
if [ $# -eq 0 ]; then
    exec tail -f /dev/null
else
    # Execute the provided command
    exec "$@"
fi
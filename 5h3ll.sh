#!/bin/sh
echo "Available Shells Are :"
echo ""
awk -F "/" ' /^\// {print $NF}' /etc/shells

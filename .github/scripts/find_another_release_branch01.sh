#!/usr/bin/env bash

# This script is used to check if there is a relase branch with a later date than the current one in its name.
# If there is a later release branch, then the current branch is not the latest release branch.
# If there is not a later release branch, then the current branch is the latest release branch.

# Confirm the name of the current branch.
current_branch=`git rev-parse --abbrev-ref HEAD`
echo "::set-output name=current_branch::$current_branch"

# Get the list of all release branches, sorted by date number in the branch name.
# The date is expected to be in the format YYYY-MM-DD.
branches=`git branch -r --sort=-committerdate | grep -E "origin/release/[0-9]{4}-[0-9]{2}-[0-9]{2}"`
echo "::set-output name=branches::$branches"

# extract the date from the each name and sort the dates in descending order.
# The latest date will be the first one in the list.
dates=`echo "$branches" | sed -e 's/origin\/release\///' | sort -r`
echo "::set-output name=dates::$dates"


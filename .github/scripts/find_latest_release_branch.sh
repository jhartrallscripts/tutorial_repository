#!/usr/bin/env bash

# This script is used to check if there is a relase branch with a later date than the current one in its name.
# If there is a later release branch, then the current branch is not the latest release branch.
# If there is not a later release branch, then the current branch is the latest release branch.

# fetch the latest changes from the remote repository.
git fetch

# Confirm the name of the current branch.
current_branch=`git rev-parse --abbrev-ref HEAD`
echo "The current branch is $current_branch"

# Get the list of all release branches, sorted by date number in the branch name.
# The date is expected to be in the format YYYY-MM-DD.
branches=`git branch -r --sort=-committerdate | grep -E "origin/release/[0-9]{4}-[0-9]{2}-[0-9]{2}"`

# sort the list of branches by date number in the branch name and use that to extract the latest one.
# The date is expected to be in the format YYYY-MM-DD.
latest_branch=`echo "$branches" | sort -r | head -n 1 | sed 's/origin\///g'`

echo "The latest branch is $latest_branch"

# Now that we have the latest branch, we set it to the output variable.
echo "latest_branch=$latest_branch" >> $GITHUB_OUTPUT

# Good work, go have a beer:
exit 0
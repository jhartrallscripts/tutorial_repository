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
echo "Extant branches are as follows: $branches"

# if the current branch is has an earlier date in its name than the latest release branch, then it is not the latest release branch.
# In this case, we want to output the name of the latest release branch.
# If the current branch is the latest release branch, then we want to output an empty string.

latest_branch=`echo "$branches" | head -n 1 | sed -e 's/origin\///'`
echo "The latest branch is $latest_branch"

# output the name of the latest release branch.
=======
# Sort the branches from newest to oldest per the date field in their name.
sorted_branches=`echo "$branches" | sort -r`
echo "::set-output name=sorted_branches::$sorted_branches"

# Set a variable for the latest branch.
latest_branch=`echo "$sorted_branches" | head -n 1 | sed -e 's/origin\///'`
echo "::set-output name=latest_branch::$latest_branch"

# Check if the current branch is the latest branch.

if [[ "$current_branch" != "$latest_branch" ]]; then
    echo "::set-output name=latest_branch::$latest_branch"
else
    echo "::set-output name=latest_branch::"
fi

# Good work, go have a beer:
exit 0
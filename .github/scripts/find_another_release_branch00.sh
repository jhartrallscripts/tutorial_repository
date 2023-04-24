#!/bin/bash
set -eu

# This script is used to find another release branch with a later date than the current one.
# It is used to determine if the current branch is the latest release branch.
# If it is not the latest release branch, then changes should be merged into both the current branch 
# and the latest release branch.

# The script takes one argument, the name of the current release branch.

current_branch=`git rev-parse --abbrev-ref HEAD`
echo "::set-output name=current_branch::$current_branch"

# Get the list of all release branches, sorted by date number in the branch name.
# The date is expected to be in the format YYYY-MM-DD.
branches=`git branch -r --sort=-committerdate | grep -E "origin/release/[0-9]{4}-[0-9]{2}-[0-9]{2}"`
echo "::set-output name=branches::$branches"

# if the current branch is has an earlier date in its name than the latest release branch, then it is not the latest release branch.
# In this case, we want to merge the changes into both the current branch and the latest release branch.

latest_branch=`echo "$branches" | head -n 1 | sed -e 's/origin\///'`

if [[ "$current_branch" != "$latest_branch" ]]; then
    echo "::set-output name=latest_branch::$latest_branch"
else
    echo "::set-output name=latest_branch::"
fi

exit 0
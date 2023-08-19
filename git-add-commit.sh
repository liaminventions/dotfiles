#!/bin/bash

# Here's a shell script that adds and commits changes in a Git repository in smaller chunks:
# Usage: git-add-commit.sh <message>

# Check if a commit message was provided
if [ $# -eq 0 ]; then
  echo "Error: No commit message provided"
  exit 1
fi

# Store the commit message in a variable
message="$1"

# Add changes in smaller chunks
for file in $(git diff --name-only --cached); do
  git add "$file"
  git commit -m "$message"
done

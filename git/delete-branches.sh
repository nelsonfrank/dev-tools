#!/bin/bash

# Get all local branches except 'main'
branches_to_delete=$(git branch | grep -v "main" | sed 's/^[* ]*//')

# If no branches to delete
if [ -z "$branches_to_delete" ]; then
  echo "No branches to delete."
  exit 0
fi

# Display branches to delete
echo "The following branches will be deleted:"
echo "$branches_to_delete"
echo

# Prompt for confirmation
read -p "Are you sure you want to delete these branches? (y/N): " confirm

if [[ "$confirm" =~ ^[Yy]$ ]]; then
  # Delete each branch
  for branch in $branches_to_delete; do
    git branch -d "$branch" || git branch -D "$branch"
  done
  echo "Branches deleted."
else
  echo "Aborted. No branches were deleted."
fi


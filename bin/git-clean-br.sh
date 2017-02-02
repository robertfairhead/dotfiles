#! /usr/bin/env bash
set -euo pipefail

git checkout master
git fetch --prune

IFS=$'\n'
REMOTES=( $(git for-each-ref --format="%(refname:short)" refs/remotes) )

IFS=$' '
git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads/ \
  | while read branch remote; do
      if [[ ! " ${REMOTES[@]} " =~ " ${remote} " ]]; then
        if [[ "${branch}" != "master" ]]; then
          git branch -D $branch
        fi
      fi
    done

#!/usr/bin/env bash
set -e # Exit with nonzero exit code if anything fails

rsync -avzn ./_site git@github.com:techhandie-corp/cornerstone.git: gh-pages
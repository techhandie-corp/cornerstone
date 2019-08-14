#!/usr/bin/env bash
set -e # Exit with nonzero exit code if anything fails

# Source master will build site
# Copy _site folder from local master
# To Github gh-pages branch

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"

# Git content SOURCE
DEPLOY_REPO="https://github.com/techhandie-corp/cornerstone.git"
# "https://${DEPLOY_SITE_TOKEN}@github.com/techandie-corp.github.io/cornerstone.git"

function main {
clean
build_site
# get_current_site
deploy
}
function clean {
  # Remove _sit folder content & folder in TATGET
echo "cleaning _site folder"
if [ -d "_site" ]; then rm -Rf _site; fi
}

# Clone

#
# git clone project/ subproject/
# cd subproject
# git filter-branch --prune-empty --subdirectory-filter dirB HEAD
#
function get_current_site {
echo "getting latest site"
# Clone local repo directory to remote repo directory
# git clone $DEPLOY_REPO https://github.com/TechHandieCorp/cornerstone/
git clone -n https://github.com/techhandie-corp/cornerstone.git https://github.com/TechHandieCorp/cornerstone.git --depth 1
cd _site
git checkout HEAD "./_site/"
# git fetch $SOURCE_BRANCH
# git checkout -b gh-pages $SOURCE_BRANCH _site
cd ..
}

function build_site {
echo "building site"
bundle exec jekyll build
}

# Actual Deployment Steps
function deploy {
  # Ignore pull requests
echo "deploying changes"

# On Local Machine
#
cd _site

git init
git remote add origin -f https://github.com/TechHandieCorp/cornerstone/

# enable this
git config core.sparseCheckout true

cat >> .git/info/sparsecheckout ./_site/
git pull origin master
}

main

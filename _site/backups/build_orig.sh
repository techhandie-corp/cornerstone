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
get_current_site
build_site
deploy
}
function clean {
  # Remove _sit folder content & folder in TATGET
echo "cleaning _site folder"
if [ -d "_site" ]; then rm -Rf _site; fi
}

# Clone
function get_current_site {
echo "getting latest site"
# Clone local repo directory to remote repo directory
git clone $DEPLOY_REPO/_site https://github.com/techhandie-corp/cornerstone/_site
cd _site
git fetch $SOURCE_BRANCH
git checkout -b $TARGET_BRANCH master/$SOURCE_BRANCH || git checkout --orphan $TARGET_BRANCH
find -maxdepth 1 ! -name .git ! -name . | xargs rm -rf
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
if [ -z "$TRAVIS_PULL_REQUEST" ]; then
echo "except don't publish site for pull requests"
exit 0
fi
if [ "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
echo "except we should only publish the master branch. stopping here"
exit 0
fi
cd _site
git config --global user.name "techhandie-corp"
git config --global user.email admin@techhandie.com
git add -A
git status
git commit -m "Lastest site built on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to
github"
git push $DEPLOY_REPO master:gh-pages
}

main
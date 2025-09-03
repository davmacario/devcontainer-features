#!/bin/bash

set -eu

REQUIREMENTS_PKG=(
    git
)

check_requirements() {
    for req in "${REQUIREMENTS_PKG[@]}"; do
        if ! [ -x "$(command -v "$req")" ]; then
            echo "Missing requirement: $req"
            exit 1
        fi
    done
}

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
        exit 1
    fi
}

check_requirements
check_root

REPO_DOTFILES=${DOTFILES_REPO:-""}
ENTRYPOINT=${DOTFILES_INSTALL_SCRIPT:-""}
CUSTOM_BRANCH=${DOTFILES_BRANCH:-""}

echo "Repo: $REPO_DOTFILES"
echo "Branch: $CUSTOM_BRANCH"
echo "Entrypoint: $ENTRYPOINT"

cd "${_REMOTE_USER_HOME}" || { echo "HOME not set"; exit 1; }
if [ ! -d "./dotfiles" ]; then
    git clone "$REPO_DOTFILES" ./dotfiles
fi
cd ./dotfiles || exit 1
if [ -n "$CUSTOM_BRANCH" ]; then
    git checkout "$CUSTOM_BRANCH"
fi
git pull -p

chown -R "$_REMOTE_USER" .

./$ENTRYPOINT

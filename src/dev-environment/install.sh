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

check_requirements

REPO_DOTFILES=${DOTFILES_REPO:-""}
ENTRYPOINT=${DOTFILES_INSTALL_SCRIPT:-""}
CUSTOM_BRANCH=${DOTFILES_BRANCH:-""}

echo "Repo: $REPO_DOTFILES"
echo "Branch: $CUSTOM_BRANCH"
echo "Entrypoint: $ENTRYPOINT"

/bin/su - "$_REMOTE_USER" <<EOF
cd "${_REMOTE_USER_HOME}" || { echo "HOME not set"; exit 1; }
if [ ! -d "./dotfiles" ]; then
    git clone "$REPO_DOTFILES" ./dotfiles
fi
cd ./dotfiles || exit 1
if [ -n "$CUSTOM_BRANCH" ]; then
    git checkout "$CUSTOM_BRANCH"
fi
git pull -p

./$ENTRYPOINT
EOF

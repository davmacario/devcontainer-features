# Dev Environment (dev-environment)

Set up custom CLI-based development environment by providing a link to a 'dotfiles' repository containing an install script.

## Example Usage

```json
"features": {
  "ghcr.io/davmacario/devcontainer-features/dev-environment:1": {
    "dotfiles_repo": "https://github.com/davmacario/dotfiles.git",
    "dotfiles_branch": "main",
    "dotfiles_install_script": "install.sh"
  }
}
```

## Options

| Options Id              | Description                                                                                                   | Type   | Default Value |
| ----------------------- | ------------------------------------------------------------------------------------------------------------- | ------ | ------------- |
| dotfiles_repo           | URL of dotfiles repository.                                                                                   | string | undefined     |
| dotfiles_branch         | Branch of the dotfiles repository to be used                                                                  | string | main          |
| dotfiles_install_script | Path to the script used to install dev environment requirements with respect to the dotfiles repository root. | string | setup.sh      |

## Dependencies

Features:

- [common-utils](ghcr.io/devcontainers/features/common-utils)
- [git](ghcr.io/devcontainers/features/git:1)

---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json). Add additional notes to a `NOTES.md`._

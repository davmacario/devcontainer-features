#!/bin/bash
set -e

# Simple check: was my-feature installed?
echo "Running test for my-feature..."

# Example: verify the remote user environment vars exist
if [ -z "${_REMOTE_USER}" ]; then
    echo "❌ _REMOTE_USER is not set"
    exit 1
fi

# Example: verify a binary was installed by your feature
if ! command -v my-binary >/dev/null; then
    echo "❌ my-binary is missing"
    exit 1
fi

echo "✅ my-feature test passed"

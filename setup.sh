#!/usr/bin/env bash

# Copy flip.sh to ~/.local/bin/

local_bin=$HOME/.local/bin
mkdir -p "$local_bin"

echo "copying flip.sh to ~/.local/bin..."
script=./flip.sh
cp "$script" "$local_bin"
echo "copy complete!"

#!/bin/bash
set -e

# sourc directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRC=$DIR/src

# Make sure src exists
mkdir -p $SRC

# change dir
cd $DIR/deps/optipng

# start configuring
emconfigure ./configure

# Make it.
emmake make

cd $DIR/deps/optipng/src/optipng

# If we can not find optipng file... Something must be wrong.
mv optipng optipng.bc

# Compite to javascript!
emcc -03 optipng.bc -s LEGACY_VM_SUPPORT=1 -s TOTAL_MEMORY=256MB --pre-js ../../../../pre.js --post-js ../../../../post.js -o optipng.js

# move to src.
mv optipng.js $SRC/optipng.js

echo "Successfully compiled optipng to javascript! Try to check $SRC"
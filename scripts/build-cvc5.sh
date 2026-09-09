#!/usr/bin/env bash
# Clones a cvc5 branch and builds it with the Java bindings, into $3.
#
# Called from the initialize phase of the build. Does nothing once the jar is there, so it
# costs one long build and then nothing; delete the directory to force a rebuild, or pass
# -Dcvc5.home=<other install> to ignore this and use a build of your own.
set -euo pipefail

url=$1
branch=$2
src=$3
install="$src/build/install"
jar="$install/share/java/cvc5.jar"

if [ -f "$jar" ]; then
  echo "cvc5 ($branch) is already built: $jar"
  exit 0
fi

for tool in git cmake; do
  command -v "$tool" > /dev/null || { echo "cvc5 needs $tool on the PATH" >&2; exit 1; }
done

if [ ! -d "$src/.git" ]; then
  echo "cloning $url ($branch) into $src"
  rm -rf "$src"
  git clone --depth 1 --branch "$branch" "$url" "$src"
fi

cd "$src"
# 'production' was renamed to 'unrestricted'; both name the same optimized, untraced build
if ./configure.sh --help 2>&1 | grep -q "unrestricted"; then
  type=unrestricted
else
  type=production
fi
jobs=$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 4)
echo "building cvc5 ($type, java bindings, -j$jobs) -- this takes a while the first time"
./configure.sh "$type" --auto-download --java-bindings --prefix="$install"
cmake --build build -j"$jobs"
cmake --install build
echo "built $jar"

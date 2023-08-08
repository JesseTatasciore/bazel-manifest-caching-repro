#!/usr/bin/env bash

CURRENT_DIRECTORY=$(pwd)

# Cleanup and create testing environment
OUTPUT_USER_ROOT_1="${CURRENT_DIRECTORY}/test/bazel1/__main__"
OUTPUT_USER_ROOT_2="${CURRENT_DIRECTORY}/test/bazel2/__main__"
OUTPUT_BASE="/${CURRENT_DIRECTORY}/test/outputs/__main__"
TEST_FOLDER="${CURRENT_DIRECTORY}/test"

sudo rm -rf "${OUTPUT_USER_ROOT_1}"
sudo rm -rf "${OUTPUT_USER_ROOT_2}"
sudo rm -rf "${OUTPUT_BASE}"
sudo rm -rf "${TEST_FOLDER}"

mkdir -p "${OUTPUT_USER_ROOT_1}"
mkdir -p "${OUTPUT_USER_ROOT_2}"
mkdir -p "${OUTPUT_BASE}"
mkdir -p "${TEST_FOLDER}"

# Perform clones
cd "${TEST_FOLDER}"
git clone https://github.com/JesseTatasciore/bazel-manifest-caching-repro.git


# Do the first build and check the manifest
cd "${TEST_FOLDER}/bazel-manifest-caching-repro"

echo "-------------------------------------"
echo "First Build"
echo "-------------------------------------"
bazel --nohome_rc --output_user_root="${OUTPUT_USER_ROOT_1}" --output_base="${OUTPUT_BASE}" build //... 

echo "-------------------------------------"
echo "First Build runfiles_manifest"
echo "-------------------------------------"
cat bazel-bin/hello_world.runfiles_manifest

# Do the second build and check the manifest

echo ""
echo ""
echo ""

echo "-------------------------------------"
echo "Second Build"
echo "-------------------------------------"
bazel --nohome_rc --output_user_root="${OUTPUT_USER_ROOT_2}" --output_base="${OUTPUT_BASE}" build //... 

echo "-------------------------------------"
echo "Second Build runfiles_manifest"
echo "-------------------------------------"
cat bazel-bin/hello_world.runfiles_manifest

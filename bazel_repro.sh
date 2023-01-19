#!/usr/bin/env bash

CURRENT_DIRECTORY=$(pwd)

# Cleanup and create testing environment
OUTPUT_USER_ROOT="${CURRENT_DIRECTORY}/test/bazel/__main__"
OUTPUT_BASE="/${CURRENT_DIRECTORY}/test/outputs/__main__"
TEST_FOLDER_1="${CURRENT_DIRECTORY}/test/test1"
TEST_FOLDER_2="${CURRENT_DIRECTORY}/test/test2"

sudo rm -rf "${OUTPUT_USER_ROOT}"
sudo rm -rf "${OUTPUT_BASE}"
sudo rm -rf "${TEST_FOLDER_1}"
sudo rm -rf "${TEST_FOLDER_2}"

mkdir -p "${OUTPUT_USER_ROOT}"
mkdir -p "${OUTPUT_BASE}"
mkdir -p "${TEST_FOLDER_1}"
mkdir -p "${TEST_FOLDER_2}"

# Perform clones
cd "${TEST_FOLDER_1}"
git clone https://github.com/JesseTatasciore/bazel-manifest-caching-repro.git

cd "${TEST_FOLDER_2}"
git clone https://github.com/JesseTatasciore/bazel-manifest-caching-repro.git


# Do the first build, confirm our directory and check the manifest
cd "${TEST_FOLDER_1}/bazel-manifest-caching-repro"

echo "-------------------------------------"
echo "First Build"
echo "-------------------------------------"
bazel --nohome_rc --output_user_root="${OUTPUT_USER_ROOT}" --output_base="${OUTPUT_BASE}" build //... 

echo "-------------------------------------"
echo "First Build PWD"
echo "-------------------------------------"
pwd 

echo "-------------------------------------"
echo "First Build runfiles_manifest"
echo "-------------------------------------"
cat bazel-bin/hello_world.runfiles_manifest

# Do the second build, confirm our directory and check the manifest
cd "${TEST_FOLDER_2}/bazel-manifest-caching-repro"

echo ""
echo ""
echo ""

echo "-------------------------------------"
echo "Second Build"
echo "-------------------------------------"
bazel --nohome_rc --output_user_root="${OUTPUT_USER_ROOT}" --output_base="${OUTPUT_BASE}" build //... 

echo "-------------------------------------"
echo "Second Build PWD"
echo "-------------------------------------"
pwd 

echo "-------------------------------------"
echo "Second Build runfiles_manifest"
echo "-------------------------------------"
cat bazel-bin/hello_world.runfiles_manifest

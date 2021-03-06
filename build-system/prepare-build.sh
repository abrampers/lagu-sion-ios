#!/bin/sh

set -e

APP_TARGET="$1"
if [ "$APP_TARGET" == "" ]; then
	echo "Usage: sh prepare-build.sh app_target"
	exit 1
fi

BASE_PATH=$(dirname $0)
PREPARE_BUILD_VARIABLES_SCRIPT="$BASE_PATH/prepare-build-variables-$APP_TARGET.sh"

if [ ! -f "$PREPARE_BUILD_VARIABLES_SCRIPT" ]; then
	echo "$PREPARE_BUILD_VARIABLES_SCRIPT not found"
	exit 1
fi

DATA_DIRECTORY="build-input/data"
rm -rf "$DATA_DIRECTORY"
mkdir -p "$DATA_DIRECTORY"
touch "$DATA_DIRECTORY/BUILD"

PROVISION_DIRECTORY="build-input/provision"
rm -rf "$PROVISION_DIRECTORY"
mkdir -p "$PROVISION_DIRECTORY"
touch "$PROVISION_DIRECTORY/BUILD"
echo "exports_files(glob([\"*.mobileprovision\"]))" >> $PROVISION_DIRECTORY/BUILD

source "$PREPARE_BUILD_VARIABLES_SCRIPT"

if [ $CI == "true" ]; then
  echo "Preparing keychain..."
  bundle exec fastlane run setup_ci
fi

echo "Preparing provisioning profiles..."
if [ $CI == "true" ]; then
  bundle exec fastlane match adhoc \
    --readonly \
    --output_path=$PROVISION_DIRECTORY \
    --keychain_name=fastlane_tmp_keychain
  bundle exec fastlane match development \
    --readonly \
    --output_path=$PROVISION_DIRECTORY \
    --keychain_name=fastlane_tmp_keychain
else
  bundle exec fastlane match adhoc \
    --readonly \
    --output_path=$PROVISION_DIRECTORY
  bundle exec fastlane match development \
    --readonly \
    --output_path=$PROVISION_DIRECTORY
fi

echo "Preparing build variables..."
prepare_build_variables

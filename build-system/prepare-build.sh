#!/bin/sh

set -e

APP_TARGET="$1"
if [ "$APP_TARGET" == "" ]; then
	echo "Usage: sh prepare-build.sh app_target development|distribution"
	exit 1
fi

BUILD_TYPE="$2"
case "$BUILD_TYPE" in
	development)
    	PROFILES_TYPE="development"
		;;
	distribution)
	    PROFILES_TYPE="distribution"
	    ;;
	*)
	    echo "Unknown build provisioning type: $BUILD_TYPE"
	    exit 1
	    ;;
esac

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

source "$PREPARE_BUILD_VARIABLES_SCRIPT"

if [ $CI == "true" ]; then
  echo "Preparing keychain..."
  bundle exec fastlane run setup_ci
fi

echo "Preparing provisioning profiles..."
if [ $CI == "true" ]; then
  bundle exec fastlane match adhoc --readonly --output_path=./LaguSion/provision/ --keychain_name=fastlane_tmp_keychain
else
  bundle exec fastlane match adhoc --readonly --output_path=./LaguSion/provision/
fi

echo "Preparing build variables..."
prepare_build_variables "$BUILD_TYPE"

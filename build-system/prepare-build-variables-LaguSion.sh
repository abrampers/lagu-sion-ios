#!/bin/sh

set -e

prepare_build_variables () {
	BUILD_TYPE="$1"
	case "$BUILD_TYPE" in
		development)
	    	APS_ENVIRONMENT="development"
			;;
		distribution)
		    APS_ENVIRONMENT="production"
		    ;;
		*)
		    echo "Unknown build provisioning type: $BUILD_TYPE"
		    exit 1
		    ;;
	esac

	local BAZEL="$(which bazel)"
	if [ "$BAZEL" = "" ]; then
		echo "bazel not found in PATH"
		exit 1
	fi

	local EXPECTED_VARIABLES=(\
		BUNDLE_VERSION \
		APP_VERSION \
		BUNDLE_ID \
		DEVELOPMENT_TEAM \
	)

	local MISSING_VARIABLES="0"
	for VARIABLE_NAME in ${EXPECTED_VARIABLES[@]}; do
		if [ "${!VARIABLE_NAME}" = "" ]; then
			echo "$VARIABLE_NAME not defined"
			MISSING_VARIABLES="1"
		fi
	done

	if [ "$MISSING_VARIABLES" == "1" ]; then
		exit 1
	fi

	local VARIABLES_DIRECTORY="build-input/data"
	mkdir -p "$VARIABLES_DIRECTORY"
	local VARIABLES_PATH="$VARIABLES_DIRECTORY/variables.bzl"
	rm -f "$VARIABLES_PATH"

	echo "lagu_sion_build_number = \"$BUNDLE_VERSION\"" >> "$VARIABLES_PATH"
	echo "lagu_sion_version = \"$APP_VERSION\"" >> "$VARIABLES_PATH"
	echo "lagu_sion_bundle_id = \"$BUNDLE_ID\"" >> "$VARIABLES_PATH"	
	echo "lagu_sion_team_id = \"$DEVELOPMENT_TEAM\"" >> "$VARIABLES_PATH"
	echo "lagu_sion_aps_environment = \"$APS_ENVIRONMENT\"" >> "$VARIABLES_PATH"
}

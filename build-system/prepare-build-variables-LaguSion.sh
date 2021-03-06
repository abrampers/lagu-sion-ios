#!/bin/sh

set -e

prepare_build_variables () {
	local BAZEL="$(which bazel)"
	if [ "$BAZEL" = "" ]; then
		echo "bazel not found in PATH"
		exit 1
	fi

	local EXPECTED_VARIABLES=(\
		BUNDLE_VERSION \
		APP_VERSION \
		BUNDLE_ID \
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

	echo "lagu_sion_bundle_version = \"$BUNDLE_VERSION\"" >> "$VARIABLES_PATH"
	echo "lagu_sion_version = \"$APP_VERSION\"" >> "$VARIABLES_PATH"
	echo "lagu_sion_bundle_id = \"$BUNDLE_ID\"" >> "$VARIABLES_PATH"	
}

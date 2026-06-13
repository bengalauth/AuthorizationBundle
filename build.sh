#!/bin/bash
set -e

#BASEDIR="${0:a:h}"
BASEDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "building authorization plugin..."

BUNDLE_NAME="BengalLogin.bundle"
BUILD_DIR="${BASEDIR}/build"

rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/$BUNDLE_NAME/Contents/MacOS"
mkdir -p "$BUILD_DIR/$BUNDLE_NAME/Contents/Resources"

cp ${BASEDIR}/Info.plist "$BUILD_DIR/$BUNDLE_NAME/Contents/"

# copy all resources (fonts, bg, avatar, settings)
cp -rf ${BASEDIR}/Resources/* "$BUILD_DIR/$BUNDLE_NAME/Contents/Resources/"

# compile into dynamic library (bundle)
SRC_FILES=(
    "${BASEDIR}/core/AuthorizationPlugin.swift"
    "${BASEDIR}/core/Mechanism.swift"
    "${BASEDIR}/core/LoginUI.swift"
    "${BASEDIR}/core/BundleLog.swift"
)

if [ -n "$APP_CORE" ]; then
    if [ ! -f "$APP_CORE/SettingsManager.swift" ]; then
        echo "APP_CORE is set, but $APP_CORE/SettingsManager.swift was not found." >&2
        exit 1
    fi
    SRC_FILES+=("$APP_CORE/SettingsManager.swift")
elif [ -f "${BASEDIR}/core/SettingsManager.swift" ]; then
    SRC_FILES+=("${BASEDIR}/core/SettingsManager.swift")
else
    echo "WARNING: no app core settings manager found; using fallback." >&2
fi

swiftc -emit-library -o "$BUILD_DIR/$BUNDLE_NAME/Contents/MacOS/BengalLogin" \
    "${SRC_FILES[@]}" \
    -Xlinker -bundle

echo "login UI built successfully: $BUILD_DIR/$BUNDLE_NAME"
echo ""
echo "run scripts/install_bundle.sh to install login UI"
echo "or install with:"
echo "  sudo cp -R $BUILD_DIR/$BUNDLE_NAME /Library/Security/SecurityAgentPlugins/"
echo ""
echo "to test, run scripts/test_login_ui.sh"

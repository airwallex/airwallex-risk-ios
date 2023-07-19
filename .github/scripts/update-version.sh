#!/usr/bin/env bash
set -euo pipefail

# Takes the new version string as a parameter
if [ -z "${VERSION}" ]; then
  echo "Missing version."
  exit 1
fi

echo "Updating version to $VERSION."
echo "{ \"version\": \"$VERSION\" }" > ./Sources/AirwallexRisk/Resources/version.json

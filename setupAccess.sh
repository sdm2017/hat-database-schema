#!/usr/bin/env bash

# Setup HAT access
echo "Setting up HAT access"
HAT_OWNER=${HAT_OWNER:-'bobplumber'}
HAT_OWNER_ID=${HAT_OWNER_ID:-`uuidgen`}
HAT_OWNER_NAME=${HAT_OWNER_NAME:-'Bob'}
HAT_OWNER_PASSWORD=${HAT_OWNER_PASSWORD:-'pa55w0rd'}

HAT_PLATFORM=${HAT_PLATFORM:-'support@hatdex.org'}
HAT_PLATFORM_ID=${HAT_PLATFORM_ID:-`uuidgen`}
HAT_PLATFORM_NAME=${HAT_PLATFORM_NAME:-'hatdex'}
HAT_PLATFORM_PASSWORD=${HAT_PLATFORM_PASSWORD:-'pa55w0rd'}

sed -e "s;%HAT_OWNER%;$HAT_OWNER;g"\
  -e "s;%HAT_OWNER_ID%;$HAT_OWNER_ID;g"\
  -e "s;%HAT_OWNER_NAME%;$HAT_OWNER_NAME;g"\
  -e "s;%HAT_OWNER_PASSWORD%;$HAT_OWNER_PASSWORD;g"\
  -e "s;%HAT_PLATFORM%;$HAT_PLATFORM;g"\
  -e "s;%HAT_PLATFORM_ID%;$HAT_PLATFORM_ID;g"\
  -e "s;%HAT_PLATFORM_NAME%;$HAT_PLATFORM_NAME;g"\
  -e "s;%HAT_PLATFORM_PASSWORD%;$HAT_PLATFORM_PASSWORD;g"\
  41_authentication.sql.template > 41_authentication.sql
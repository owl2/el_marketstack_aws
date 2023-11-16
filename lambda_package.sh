#!/bin/bash

PROJECT_DIRECTORY="el_marketstack_aws"
ZIP_FILE_NAME="lambda_el_marketstack_package.zip"


# Ensure the project directory exists
if [ ! -d "$PROJECT_DIRECTORY" ]; then
  echo "Error: Invalid project directory"
  exit 1
fi

# Create a temporary directory for staging files
mkdir tmp

# Copy the developments into the package
cd el_marketstack_aws
zip -r ../"$ZIP_FILE_NAME" .
cd ..

# Copy the virtual env bin into the package
cd .venv/lib/python3.8/site-packages
zip -r ../../../../"$ZIP_FILE_NAME" .
cd ../../../..

# Clean up temporary directory
rm -r tmp

echo "Packaging successful. Zip file created: $ZIP_FILE_NAME"

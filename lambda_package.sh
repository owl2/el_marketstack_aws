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

# Copy main.py to the temporary directory
cp -r "$PROJECT_DIRECTORY"/* tmp

# Copy the .venv directory to the temporary directory
# cp -r ".venv" tmp

ls -al tmp

# Create the zip file
zip -r "$ZIP_FILE_NAME" -j "$TEMP_DIR/"

# Clean up temporary directory
rm -r tmp

echo "Packaging successful. Zip file created: $ZIP_FILE_NAME"

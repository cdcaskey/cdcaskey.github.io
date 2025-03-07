#!/bin/bash

# Filetypes to be deleted (providing the file starts with dev)
filetypes=("jpg")

# Loop over the filetypes array
for ext in "${filetypes[@]}"; do
    # Find and remove files that start with "dev-" and have the specified extension
    find content -type f -name "dev-*$ext" -exec rm -f {} \;
done

# Find all markdown files (.md)
find content -type f -name "*.md" | while read -r file; do
    # Check if the file contains YAML front matter and "dev: true"
    if sed -n '/^---$/,/^---$/p' "$file" | grep -q "dev: true"; then
        # Remove the markdown file if it contains "dev: true" in the YAML front matter
        rm -f "$file"
        echo "Deleted: $file"
    fi
done

echo "Deleted all development pages."
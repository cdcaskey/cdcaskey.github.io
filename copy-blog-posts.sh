#!/bin/bash

# Function to determine the correct destination (file or directory)
get_post_location() {
    local file="$1"
    local default_dir="content/posts/$(basename "$file")"  # Default file path

    # Extract front matter and check for customLocation
    local custom_location=$(awk '
    BEGIN { inside_front_matter=0 }
    /^---$/ { front_matter_count++; if (front_matter_count == 2) exit }
    front_matter_count == 1 && /^customLocation:/ { print $2; exit }
    ' "$file")

    # If customLocation is set, return it; otherwise, return the default directory
    if [[ -n "$custom_location" ]]; then
        echo "$custom_location"
    else
        echo "$default_dir"
    fi
}

# Function to check if "blogPost: true" appears within the first front matter block
contains_blogpost_true() {
    local file="$1"
    awk '
    BEGIN { inside_front_matter=0 }
    /^---$/ { front_matter_count++ }
    front_matter_count == 1 && /blogPost: true/ { print "MATCH"; exit }
    front_matter_count == 2 { exit }
    ' "$file" | grep -q "MATCH"
}

# Find all markdown files and process them
find obsidian-notes -type f \( -iname "*.md" -o -iname "*.markdown" \) | while read -r file; do
    if contains_blogpost_true "$file"; then
        destination=$(get_post_location "$file")  # Get file/directory path

        # Check if destination is a directory (ends with `/` or already exists as a folder)
        if [[ -d "$destination" || "$destination" =~ /$ ]]; then
            mkdir -p "$destination"  # Ensure directory exists
            mv "$file" "$destination/"
            echo "Moved: $file → $destination/"
        else
            mkdir -p "$(dirname "$destination")"  # Ensure parent directory exists
            mv "$file" "$destination"
            echo "Moved: $file → $destination"
        fi
    fi
done

echo "All matching files have been moved to their respective locations."
#!/bin/bash

# Function to check if "blogPost: true" appears within the first two "---"
contains_blogpost_true() {
    local file="$1"
    awk '
    BEGIN { inside_front_matter=0 }
    /^---$/ { front_matter_count++ }
    front_matter_count == 1 && /blogPost: true/ { print "MATCH"; exit }
    front_matter_count == 2 { exit }
    ' "$file" | grep -q "MATCH"
}

# Find all markdown files and check their front matter
find obsidian-notes -type f \( -iname "*.md" -o -iname "*.markdown" \) | while read -r file; do
    if contains_blogpost_true "$file"; then
        # Copy matching files to output directory
        cp "$file" content/posts
        echo "Copied: $file"
    fi
done
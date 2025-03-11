#!/bin/bash

# Check environment
command -v echo >/dev/null 2>&1 || { echo "Error: 'echo' command not found"; exit 1; }

# Function definition
print_hello() {
  echo "Hello, World!"
}

# Main execution
print_hello

exit 0
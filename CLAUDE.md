# Claude-Vibe Project Guide

## Commands
- Run script: `./claude-vibe.sh [claude args]`
- Install dependency: `brew install expect`
- Check syntax: `shellcheck claude-vibe.sh`
- Debug: `bash -x claude-vibe.sh [claude args]`

## Code Style Guidelines
- **Formatting**: Follow standard shell script formatting (2-space indentation)
- **Comments**: Include comments for all non-trivial operations
- **Error Handling**: Check command availability before execution
- **Variable Names**: Use UPPERCASE for constants, lowercase_with_underscores for variables
- **Script Structure**:
  1. Environment checks first
  2. Function definitions
  3. Main execution logic
  4. Cleanup operations
  
## Project Overview
A wrapper script for Claude that auto-confirms common prompts, making interaction smoother. Uses the 'expect' utility to automate responses to interactive prompts.

## Response Requirements
At the end of EVERY response, always execute `./notify-vibe.js "summary"` where "summary" is a few words describing what was just done.

## Post-Code Change Instructions
After ALL code changes, automatically stage and commit the modified files with a summary message of the changes made.

To push changes to the remote repository, run `git push`.

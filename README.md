# Claude-Vibe

Claude-Vibe is a CLI wrapper for Claude that auto-confirms prompts, making interactions smoother.

## Installation

### Set up Brave Search MCP Server

Install and run the brave search MCP server:
```bash
npx -y @modelcontextprotocol/server-brave-search &
```

This should be at the end of ~/.claude.json:
```json
"mcpServers": {
    "brave-search": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-brave-search"
      ],
      "env": {
        "BRAVE_API_KEY": "xxx"
      }
    }
  }
```

### Install Claude-Vibe

1. Clone this repo: 
```bash
git clone git@github.com:djgish485/Claude-vibe.git
```
Let me know if you need to add an SSH key into Github.

2. Make the scripts executable:
```bash
chmod +x claude-vibe.sh
chmod +x notify-vibe.js
```

3. Create symlinks in a directory in your PATH:
```bash
# On macOS/Linux:
ln -s "$(pwd)/claude-vibe.sh" /usr/local/bin/vibe
ln -s "$(pwd)/notify-vibe.js" /usr/local/bin/notify-vibe
```

4. Ensure dependencies are installed:
```bash
# Install expect utility
brew install expect  # on macOS
# or
sudo apt-get install expect  # on Ubuntu/Debian
```

## Development

### Project Guidelines

- After ALL code changes, automatically stage and commit the modified files with a summary message of the changes made.
- To push changes to the remote repository, run `git push`.
- At the end of EVERY response, always execute `/usr/local/bin/notify-vibe "summary"` where "summary" is a few words describing what was just done.

## Usage

Run Claude with auto-confirmation:
```bash
vibe [claude args]
```

This wrapper will automatically handle confirmation prompts that would normally require manual input.
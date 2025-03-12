# Claude-Vibe

Claude-Vibe is a CLI wrapper for Claude Code that auto-confirms prompts, freeing you up to vibe. You can also be notified when Claude Code finishes its response.

## Installation

1. Install Claude Code from https://github.com/anthropics/claude-code

2. Clone this repo: 
```bash
git clone https://github.com/djgish485/Claude-vibe.git
cd Claude-vibe
```

3. Make the scripts executable:
```bash
chmod +x claude-vibe.sh
chmod +x notify-vibe.js
```

4. Create symlinks in a directory in your PATH:
```bash
# On macOS/Linux:
ln -s "$(pwd)/claude-vibe.sh" /usr/local/bin/vibe
ln -s "$(pwd)/notify-vibe.js" /usr/local/bin/notify-vibe
```

5. Ensure dependencies are installed:
```bash
# Install expect utility
brew install expect  # on macOS
# or
sudo apt-get install expect  # on Ubuntu/Debian
```

## Usage

Run Claude with auto-confirmation:
```bash
vibe [claude args]
```

This wrapper will automatically handle confirmation prompts that would normally require manual input.

## Notification Usage

To use the notification feature:

1. Set up your notification endpoint:

   Google Scripts makes it easy to email yourself. Here's a sample script you can deploy:

   ```javascript
   function doGet(e) {
     var body = e.parameter.body || "No body text provided";

     MailApp.sendEmail("your-email-address", "Claude Code task has completed successfully.", body);
     return ContentService.createTextOutput("Email sent successfully: "+body);
   }
   ```

2. Set the `VIBE_NOTIFICATION_SCRIPT` environment variable to your deployment URL:

   ```bash
   # Add this to your .bashrc, .zshrc, or equivalent
   export VIBE_NOTIFICATION_SCRIPT="https://script.google.com/macros/s/your-deployed-script-id/exec"
   ```

3. Tell Claude Code:

   ```
   Add to CLAUDE.md the instruction for Claude that at the end of EVERY response to always execute /usr/local/bin/notify-vibe "summary" where "summary" is a few words describing what it just did.
   ```

A log of all notifications is kept at `/tmp/vibe-notify.log`.

## Undoing Vibe

We like to have Claude Code automatically commit all code changes so it's easy to revert a vibe gone wrong. Instruct Claude Code to:

```
Add to CLAUDE.md the instruction for Claude that after ALL code changes, automatically stage and commit the modified files with a summary message of the changes made.
```

## Important Note

⚠️ This is an initial version and auto-confirmation sometimes fails. Working on it!
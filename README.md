# Claude-Vibe

Claude-Vibe is a CLI wrapper for Claude that auto-confirms prompts, freeing you up to vibe. You can also be notified when Claude Code finishes its response.

## Installation

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

## Usage

Run Claude with auto-confirmation:
```bash
vibe [claude args]
```

This wrapper will automatically handle confirmation prompts that would normally require manual input.

## Notification Usage

To use the notification feature, edit notify-vibe.js and add your Google Script (or however you want to be notified). Then run this in Claude (Vibe) Code:

```
Add to CLAUDE.md the instruction for Claude that at the end of EVERY response to always execute /usr/local/bin/notify-vibe "summary" where "summary" is a few words describing what it just did.
```

A log of all notifications is kept at `/tmp/vibe-notify.log`.

Google Scripts makes it easy to email yourself. Here's a sample script you can deploy:

```javascript
function doGet(e) {
  var body = e.parameter.body || "No body text provided";

  MailApp.sendEmail("your-email-address", "vibing: "+body, "Your Claude Code task has completed successfully.");
  return ContentService.createTextOutput("Email sent successfully: "+body);
}
```

Then paste the deployment URL into notify-vibe.js
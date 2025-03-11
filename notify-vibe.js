#!/usr/bin/env node

/**
 * Vibe Notify - Simple notification script for Claude Code
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const LOG_FILE = '/tmp/vibe-notify.log';
const DEFAULT_TITLE = 'Claude Complete';

// Initialize log
fs.writeFileSync(LOG_FILE, `Started at ${new Date().toISOString()}\n`);

// Parse command line arguments - just take the first argument
const message = process.argv.slice(2).join(' ') || 'Task completed';

// Send notification
try {
  // Sanitize the message to replace problematic characters
  const safeMessage = message.replace(/'/g, '').replace(/["\\\n\r]/g, ' ');
  
  // Comment out the macOS notification
  // execSync(`osascript -e 'display notification "${safeMessage}" with title "${DEFAULT_TITLE}"'`);
  
  // Use the new web URL with body parameter
  const baseUrl = "GOOGLE_SCRIPT_URL";
  const urlEncodedMessage = encodeURIComponent(safeMessage);
  const curlCommand = `curl -s "${baseUrl}?body=${urlEncodedMessage}"`;
  execSync(curlCommand);
  
  fs.appendFileSync(LOG_FILE, `Sent notification to web service: ${DEFAULT_TITLE} - ${safeMessage}\n`);
  console.log(`Notification sent: ${message}`);
} catch (error) {
  fs.appendFileSync(LOG_FILE, `Error sending notification: ${error.message}\n`);
  console.error(`Error: ${error.message}`);
}
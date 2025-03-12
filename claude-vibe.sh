#!/bin/bash

# Claude Vibe
# Auto-confirms prompts for Claude

# Check for expect
if command -v expect &> /dev/null; then
    USE_EXPECT=true
else
    echo "Warning: 'expect' is not installed. Auto-confirmation will not work."
    echo "Please install it with: brew install expect"
    USE_EXPECT=false
fi

# Start Claude with auto-confirmation
if $USE_EXPECT; then
    # Create an expect script for auto-confirmation
    cat > /tmp/claude_vibe.exp << 'EOF'
#!/usr/bin/expect -f

# Get command line arguments
set args [lrange $argv 0 end]

# Initialize variables for keeping track of recent output
set output_buffer ""

# Start claude with the arguments
spawn -noecho claude {*}$args

# Set timeout for expect commands - using a reasonable value instead of unlimited
set timeout 2

# Auto-confirmation patterns
expect_after {
    "Do you want to make this edit to" {
        send "\r"
        exp_continue
    }
    
    "Do you want to" {
        send "\r"
        exp_continue
    }
    
    "Y/n" {
        send "y\r"
        exp_continue
    }
    
    "Continue?" {
        send "\r"
        exp_continue
    }
    
    "? ❯ Yes" {
        send "\r"
        exp_continue
    }
    
    "│ ❯ Yes" {
        send "\r"
        exp_continue
    }
    
    "is this ok?" {
        send "\r"
        exp_continue
    }
}

# Main interaction loop with improved buffer handling
interact {
    -o 
    -re . {
        # Get the current character
        set char $interact_out(0,string)
        
        # Collect output character by character for auto-confirmation
        append output_buffer $char
        
        # Process buffer in chunks to avoid overwhelming with fast output
        after 10
        
        # Auto-confirmation for prompts
        if {[string match "*Do you want to make this edit to*" $output_buffer] || 
            [string match "*Do you want to*" $output_buffer] || 
            [string match "*Y/n*" $output_buffer] || 
            [string match "*Continue?*" $output_buffer] || 
            [string match "*\? ❯ Yes*" $output_buffer] || 
            [string match "*│ ❯ Yes*" $output_buffer] || 
            [string match "*is this ok\?*" $output_buffer]} {
            
            # Add a small delay before sending confirmation to ensure prompt is fully rendered
            after 50
            send -- "\r"
            set output_buffer ""
        }
        
        # Keep buffer at reasonable size but increased to handle more output
        if {[string length $output_buffer] > 1000} {
            set output_buffer [string range $output_buffer end-999 end]
        }
        
        # Pass the output to the user
        send_user -- $char
    }
}
EOF

    # Make the expect script executable
    chmod +x /tmp/claude_vibe.exp

    # Run the expect script
    /tmp/claude_vibe.exp "$@"

    # Clean up
    rm -f /tmp/claude_vibe.exp
else
    # If expect is not available, just run claude directly
    claude "$@"
fi

exit $?

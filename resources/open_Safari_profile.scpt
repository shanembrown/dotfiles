on run {profileName}
    tell application "Safari"
        activate
        delay 1 -- Wait for Safari to activate
        tell application "System Events"
            tell process "Safari"
                try
                    -- Open the "New Window" submenu
                    click menu item "New Window" of menu 1 of menu bar item "File" of menu bar 1
                    delay 0.5 -- Allow time for the submenu to open
                    -- Click the specific profile window item
                    click menu item ("New " & profileName & " Window") of menu 1 of menu item "New Window" of menu 1 of menu bar item "File" of menu bar 1
                on error
                    display dialog "Could not find the menu item for profile: " & profileName
                end try
            end tell
        end tell
    end tell
end run

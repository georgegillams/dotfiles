#!/usr/bin/osascript
on run argv
    set the clipboard to (POSIX file (first item of argv))
end run
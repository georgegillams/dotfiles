#!/bin/bash

# Validate arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <Bundle_ID> <Extension>"
    echo "Example: $0 com.microsoft.VSCode txt"
    exit 1
fi

BUNDLE_ID=$1
EXT="${2#.}"

osascript -l JavaScript - "$BUNDLE_ID" "$EXT" <<'EOF'
function run(argv) {
    var bundleID = argv[0];
    var ext = argv[1];

    ObjC.import('CoreServices');
    ObjC.import('stdlib'); // Fixes the $.exit bug

    var extCF = $(ext);
    var bundleCF = $(bundleID);

    // 1. Get the UTI pointer from macOS
    var utiCF = $.UTTypeCreatePreferredIdentifierForTag($("public.filename-extension"), extCF, null);
    
    if (!utiCF) {
        console.log("Error: Could not determine UTI for extension '." + ext + "'");
        $.exit(1);
    }

    // 2. Pass the RAW pointer directly to LaunchServices (0xFFFFFFFF = All Roles)
    var status = $.LSSetDefaultRoleHandlerForContentType(utiCF, 0xFFFFFFFF, bundleCF);

    // 3. Smart Fallback for OSStatus -50 (Try assigning as 'Viewer' only)
    if (status === -50) {
        status = $.LSSetDefaultRoleHandlerForContentType(utiCF, 2, bundleCF); 
    }

    if (status === 0) {
        console.log("Success! " + bundleID + " is now the default app for ." + ext + " files.");
        $.exit(0);
    } else {
        console.log("Failed to set default app. LaunchServices OSStatus code: " + status);
        if (status === -10814) {
            console.log("Hint: Bundle ID '" + bundleID + "' not found.");
        }
        $.exit(1);
    }
}
EOF
echo "Register a fingerprint inside System Touch ID Settings"
echo "Press any key once complete"
read

# Add auth    sufficient    pam_tid.so
# To the top of /etc/pam.d/sudo
# unless it already exists
if ! grep -q "pam_tid.so" /etc/pam.d/sudo; then
  awk '
    !inserted && $0 !~ /^#/ {
      print "auth       sufficient     pam_tid.so"
      inserted=1
    }
    { print }
    END { if (!inserted) print "auth       sufficient     pam_tid.so" }
  ' /etc/pam.d/sudo | sudo tee /etc/pam.d/sudo > /dev/null
fi
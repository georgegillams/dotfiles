echo "Please enter the type of setup — either WORK or PERSONAL"
if sysctl hw.model | grep -q "Mac14"; then
  setup_type="WORK"
else
  setup_type="PERSONAL"
fi
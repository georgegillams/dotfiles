if sysctl hw.model | grep -q "Mac14"; then
  setup_type="WORK"
else
  setup_type="PERSONAL"
fi
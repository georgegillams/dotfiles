if sysctl machdep.cpu.brand_string | grep -q "Apple M2 Pro"; then
  setup_type="WORK_SETUP_PROFILE_1"
else
  setup_type="PERSONAL_SETUP_PROFILE_1"
fi
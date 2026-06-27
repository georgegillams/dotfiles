if sysctl machdep.cpu.brand_string | grep -q "Apple M5"; then
  echo "Apple M5 detected"
  export setup_type="WORK_SETUP_PROFILE_2"
else
  echo "Other CPU detected"
  export setup_type="PERSONAL_SETUP_PROFILE_1"
fi

echo "Setup type: $setup_type"
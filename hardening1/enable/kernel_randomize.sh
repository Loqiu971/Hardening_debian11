printf "
kernel.randomize_va_space = 2
" >> /etc/sysctl.d/60-kernel_sysctl.conf

echo 2 > /proc/sys/kernel/randomize_va_space
sed -i a "kernel.randomize_va_space = 2" /etc/sysctl.conf
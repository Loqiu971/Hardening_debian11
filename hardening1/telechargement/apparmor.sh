apt install -y apparmor apparmor-utils 
sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"/g' /etc/default/grub
sed -i 's/grub-mkconfig/\/sbin\/grub-mkconfig/g' /sbin/update-grub
/sbin/update-grub
sed -i 's/\sbin\/grub-mkconfig/grub-mkconfig/g' /sbin/update-grub
/sbin/aa-enforce /etc/apparmor.d/*
/sbin/aa-complain /etc/apparmor.d/*

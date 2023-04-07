{ mkIfDevice, lib, pkgs, ... }:

let
  inherit (lib) mkIf mkMerge;
in

mkMerge [
  {
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    environment.systemPackages = with pkgs; [ virt-manager spice-gtk ];

    users.users.noobstar.extraGroups = [ "libvirtd" ];
  }

  (mkIfDevice "desktop" {
    boot.kernelModules = [ "vfio-pci" ];
    boot.kernelParams = [ "iommu=pt" "amd_iommu=on" "rd.driver.pre=vfio-pc" ];

    environment = {
      systemPackages = with pkgs; [ virt-manager spice-gtk ];
      etc = {
        "libvirt/hooks/kvm.conf" = {
          text = ''
            ## Virsh devices
            VIRSH_GPU_VIDEO=pci_0000_25_00_0
            VIRSH_GPU_AUDIO=pci_0000_25_00_1
          '';
        };

        "libvirt/hooks/qemu.d/win10/prepare/begin/start.sh" = {
          text = ''
            #!${pkgs.bash}/bin/bash
            # Helpful to read output when debugging
            set -x
            # Load the config file with our environmental variables
            source "/etc/libvirt/hooks/kvm.conf"
            # Stop your display manager. If you're on kde it'll be sddm.service. Gnome users should use 'killall gdm-x-session' instead
            systemctl stop lightdm.service
            # Unbind VTconsoles
            echo 0 > /sys/class/vtconsole/vtcon0/bind
            # Some machines might have more than 1 virtual console. Add a line for each corresponding VTConsole
            # echo 0 > /sys/class/vtconsole/vtcon1/bind
            # Unbind EFI-Framebuffer
            echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
            # Avoid a race condition by waiting a couple of seconds. This can be calibrated to be shorter or longer if required for your system
            sleep 5
            # Unload all Nvidia drivers
            modprobe -r nvidia_uvm
            modprobe -r nvidia_drm
            modprobe -r nvidia_modeset
            modprobe -r drm_kms_helper
            modprobe -r nvidia
            modprobe -r i2c_core
            modprobe -r drm
            # Unbind the GPU from display driver
            virsh nodedev-detach $VIRSH_GPU_VIDEO
            virsh nodedev-detach $VIRSH_GPU_AUDIO
            # Load VFIO kernel module
            modprobe vfio
            modprobe vfio_pci
            modprobe vfio_iommu_type1
          '';
        };

        "libvirt/hooks/qemu.d/win10/release/end/revert.sh" = {
          text = ''
            #!${pkgs.bash}/bin/bash
            set -x
            # Load the config file with our environmental variables
            source "/etc/libvirt/hooks/kvm.conf"
            # Unload VFIO-PCI Kernel Driver
            modprobe -r vfio_pci
            modprobe -r vfio_iommu_type1
            modprobe -r vfio
            # Re-Bind GPU to our display drivers
            virsh nodedev-reattach $VIRSH_GPU_VIDEO
            virsh nodedev-reattach $VIRSH_GPU_AUDIO
            # Rebind VT consoles
            echo 1 > /sys/class/vtconsole/vtcon0/bind
            # echo 0 > /sys/class/vtconsole/vtcon1/bind
            # Read our nvidia configuration when before starting our graphics
            nvidia-xconfig --query-gpu-info > /dev/null 2>&1
            # Re-Bind EFI-Framebuffer
            echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind
            # Load nvidia drivers
            modprobe nvidia_uvm
            modprobe nvidia_drm
            modprobe nvidia_modeset
            modprobe drm_kms_helper
            modprobe nvidia
            modprobe i2c_core
            modprobe drm
            # Restart Display Manager
            systemctl start lightdm.service
          '';
        };
      };
    };
  })
]
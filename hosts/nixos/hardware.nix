{
	config,
	lib,
	pkgs,
	modulesPath,
	inputs,
	...
}:

{
	imports = [
		inputs.disko.nixosModules.disko
		(modulesPath + "/profiles/qemu-guest.nix")

		(import ./disks.nix { inherit lib; })
	];

	boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-intel" ];
	boot.extraModulePackages = [ ];

	# Use the systemd-boot EFI boot loader.
	boot.loader = {
		systemd-boot.enable = true;
		efi = {
			canTouchEfiVariables = true;
			efiSysMountPoint = "/efi";
		};
	};

	swapDevices = [ ];

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
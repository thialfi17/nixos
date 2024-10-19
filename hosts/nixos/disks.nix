{
	lib,
	disks ? [ "/dev/vda" ],
	...
}:
{
	disko.devices = {
		disk = {
			main = {
				type = "disk";
				device = builtins.elemAt disks 0;
				content = {
					type = "gpt";
					partitions = {
						ESP = {
							size = "1G";
							# This type is from `sgdisk -L`
							type = "EF00";
							content = {
								type = "filesystem";
								format = "vfat";
								mountpoint = "/efi";
							};
						};
						luks = {
							size = "100%";
							content = {
								type = "luks";
								name = "root";
								settings.allowDiscards = true;
								askPassword = true;

								content = {
									type = "filesystem";
									format = "ext4";
									mountpoint = "/";
								};
							};
						};
					};
				};
			};
		};
	};
}

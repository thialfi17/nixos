{
	username,
	desktop ? null,
	lib,
	outputs,
	inputs,
	stateVersion,
	...
}:
{
	imports = [
		./shell
	];# ++ lib.optional (builtins.isString desktop) ./desktops;

	home = {
		inherit username stateVersion;
		homeDirectory = "/home/${username}";
	};

	nixpkgs = {
		#overlays = import ../overlays {inherit inputs};
		overlays = [ outputs.overlays.unstable-packages ];

		config = {
			allowUnfree = true;
		};
	};
}

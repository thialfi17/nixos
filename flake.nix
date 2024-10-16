{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = {
		self,
		nixpkgs,
		...
	} @ inputs: let 
		inherit (self) outputs;
	in {
		overlays = import ./overlays { inherit inputs; };

		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs outputs; };
				modules = [
					./configuration.nix
					./hardware-configuration.nix
				];
			};
		};
	};
}

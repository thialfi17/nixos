{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {
		self,
		nixpkgs,
		home-manager,
		...
	} @ inputs: let 
		inherit (self) outputs;
		stateVersion = "24.05";
	in {
		overlays = import ./overlays { inherit inputs; };

		nixosConfigurations = {
			nixos = let 
				hostname = "nixos";
			in nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs outputs stateVersion; };
				modules = [
					./hosts/${hostname}/configuration.nix
				];
			};
		};

		homeConfigurations = {
			"josh@nixos" = home-manager.lib.homeManagerConfiguration {
				# TODO: replace this with a ${system} variable?
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = { inherit inputs outputs stateVersion; };
				modules = [];
			};
		};
	};
}

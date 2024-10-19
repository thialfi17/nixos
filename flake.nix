{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = {
		self,
		nixpkgs,
		home-manager,
		...
	} @ inputs: let 
		inherit (self) outputs;
		stateVersion = "24.05";
		systems = [
			"aarch64-linux"
			"x86_64-linux"
		];
		forAllSystems = nixpkgs.lib.genAttrs systems;
	in {
		overlays = import ./overlays { inherit inputs; };

		#packages = forAllSystems (
		#	system: let
		#		pkgs = nixpkgs.legacyPackages.${system};
		#	in import ./pkgs { inherit pkgs; }
		#);

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
			"josh@nixos" = let
				username = "josh";
				#desktop = "river";
			in home-manager.lib.homeManagerConfiguration {
				# TODO: replace this with a ${system} variable?
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = { inherit inputs outputs stateVersion username; };
				modules = [
					./home
				];
			};
		};
	};
}

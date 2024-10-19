{
	pkgs,
	self,
	...
}:
{
	programs = {
		eza.enable = true;
		git.enable = true;
		home-manager.enable = true;
	};
}

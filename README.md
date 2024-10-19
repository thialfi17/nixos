# My Personal NixOS configurations

Still a heavy work in progress. Not sure yet if I would like to switch fully
but I like the idea of a fully reproducible system that is (supposedly) trivial
to restore.

# How to Setup Systems

No idea if this is correct but it seems to be working for me:

```
$ nix-shell -p disko

nix-shell$ disko-install --flake .#{hostname}
```

The `disko-install` command should fail due to not providing a mapping for
the drives but it tells you what drives you need to map. This should be
fairly intuitive.

# TODO

- Should `disko-install` be prompting me for drives or is there a way to
get it to use the correct ones automatically?
- Secure Boot
- Yubikey Full-Disk Encryption (FDE)
- Home Manager as a module?
    - Should allow home manager to be run as part of `nixos-rebuild`

# Credits

Major inspiration has been taken from
[jnsgruk](https://github.com/jnsgruk/nixos-config) and
[Misterio77](https://github.com/Misterio77/nix-starter-configs).

A big thanks to [LibrePhoenix](https://www.youtube.com/@librephoenix) for
your various Nix tutorials.

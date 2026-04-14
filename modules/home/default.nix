# A module that automatically imports everything else in the parent folder.
{pkgs, ...}:
let
  exclude = [
    "default.nix"
    "easyeffects.nix"
    "emacs.nix"
  ];
in
{
  imports =
    with builtins;
    map
      (fn: ./${fn})
      (filter (fn: ! builtins.elem fn exclude) (attrNames (readDir ./.)));
}

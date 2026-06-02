{ pkgs, ... }: {
  virtualisation.docker.enable = true;
  users.users.abec.extraGroups = [ "docker" ];
}

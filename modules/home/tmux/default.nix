{
  programs.tmux = {
    enable = true;
    shortcut = "s";
    baseIndex = 1;
    mouse = true;
    newSession = true;
    extraConfig = (builtins.readFile ./tmux.conf);
  };
}

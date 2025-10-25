{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.bitstream-vera-sans-mono
    ipafont
  ];
}

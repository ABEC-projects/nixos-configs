{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.bitstream-vera-sans-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.symbols-only
    nerd-fonts._3270
    ipafont
  ];
}

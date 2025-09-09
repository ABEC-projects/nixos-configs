{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "1.15.5b";
  pname = "zen-browser";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/tag/${version}/zen-x86_64.AppImage";
    hash = "sha256-tHQhMxFLbkMZVHfbNBgg5ENqDHOC6ZIcSru4r132ZIg=";
  };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  extraInstallCommands = ''
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${meta.mainProgram}'
  '';

  meta = {
    description = "Welcome to a calmer internet";
    homepage = "https://github.com/zen-browser/desktop";
    downloadPage = "https://github.com/zen-browser/desktop/releases";
    license = lib.licenses.mpl20;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = [  ];
    mainProgram = "zen-browser";
    platforms = [ "x86_64-linux" ];
  };
}

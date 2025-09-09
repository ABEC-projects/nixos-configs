{
  lib,
  appimageTools,
  fetchurl,
  makeDesktopItem,
  copyDesktopItems,
}:

let
  version = "1.15.5b";
  pname = "zen-browser";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/tag/${version}/zen-x86_64.AppImage";
    hash = "sha256-tHQhMxFLbkMZVHfbNBgg5ENqDHOC6ZIcSru4r132ZIg=";
  };

  desktopItem = makeDesktopItem {
    name = "Zen Browser";
    exec = "zen-browser";
    desktopName = "Zen Browser";
    startupWMClass = "zen_browser_app";
    genericName = "Welcome to a calmer internet";
    categories = [
      "Internet"
    ];
    keywords = [
      "Browser"
    ];
  };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  nativeBuildInputs = [ copyDesktopItems ];

  desktopItem = makeDesktopItem {
    name = "Zen Browser";
    exec = "zen-browser";
    desktopName = "Zen Browser";
    startupWMClass = "zen_browser_app";
    genericName = "Welcome to a calmer internet";
    keywords = [
      "Browser"
    ];
  };
  extraInstallCommands = ''
    mkdir -p $out/share/applications/
    cp ${desktopItem}/share/applications/*.desktop $out/share/applications/
  '';

  meta = {
    description = "Welcome to a calmer internet";
    homepage = "https://github.com/zen-browser/desktop";
    downloadPage = "https://github.com/zen-browser/desktop/releases";
    license = lib.licenses.mpl20;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = [ ];
    mainProgram = "zen-browser";
    platforms = [ "x86_64-linux" ];
  };
}

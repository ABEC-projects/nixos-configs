{...}: {
  networking.interfaces.enp34s0 = {
    useDHCP = true;
    ipv4.addresses = [
      {
        address = "192.168.88.3";
        prefixLength = 24;
      }
    ];
  };
}

{
  services.openssh = {
    enable = true;
    listenAddresses = [
      { addr = "127.0.0.1"; port = 20480; }
      { addr = "10.0.0.16"; port = 22; }
    ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}

{
  services.openssh = {
    enable = true;
    listenAddresses = [
      { addr = "127.0.0.1"; port = 20480; }
    ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}

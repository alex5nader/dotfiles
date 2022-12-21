{
  services.openvpn.servers = {
    nord-us = {
      config = "config ${./vpn/nord-us6898.ovpn}";
      autoStart = false;
    };
  };
}
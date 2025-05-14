{ hostname, ... }:
{
  sops = {
    defaultSopsFile = ../../../secrets/public/${hostname}.yaml;
  };
}
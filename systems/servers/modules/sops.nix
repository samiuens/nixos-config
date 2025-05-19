{ hostname , ...}: {
  sops.defaultSopsFile = ../../../secrets/public/${hostname}.yaml;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
}
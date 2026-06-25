{ pkgs, ... }:
{
  users.users.axiom = {
    isSystemUser = true;
    group = "axiom";
    home = "/home/axiom";
    createHome = true;
    shell = pkgs.fish;
  };

  users.groups.axiom = {};

  environment.systemPackages = with pkgs; [
    uv
    tmux
    gh
    jq
    htop
    curl
    iperf3
    git
    vim
    ripgrep
    fd
    fzf
    tree 
    rsync
    unzip
  ];

  systemd.tmpfiles.rules = [
    "d /home/axiom/.nanobot 0750 axiom axiom -"
    "d /home/axiom/.nanobot/workspace 0750 axiom axiom -"
    "d /home/axiom/.nanobot/workspace/memory 0750 axiom axiom -"
  ];

  systemd.services.axiom = {
    description = "Axiom nanobot gateway";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "axiom";
      Group = "axiom";
      WorkingDirectory = "/home/axiom/.nanobot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'set -a; source /home/axiom/.nanobot/.env; set +a; /home/axiom/.local/bin/nanobot gateway'";
      Restart = "on-failure";
      RestartSec = 10;

      NoNewPrivileges = true;
      PrivateTmp = true;
      ProtectHome = false;
      ReadWritePaths = [ "/home/axiom/.nanobot" ];
    };
  };
}
{config, lib, pkgs, ...}:

with lib;

let 
  cfg = config.services.git-deploy;

  gitDeploy = {...} : {
    options = {
      path = mkOption {
        type = types.path;
        description = "Path to the repository";
      };
      user = mkOption {
        type = with types; uniq str;
        description = "The user used for building and pushing the code";
      };
      start = mkOption {
        type = types.str;
        description = "Run on start";
      };
      stop = mkOption {
        type = types.str;
        description = "Run on stop";
      };
    };
  };

  mkUser = cfg: {
    name = cfg.user;
    shell = "${pkg.git}/bin/git-shell";
    isSystemUser = true;
  };

  mkSetupService = name: cfg: {
    wantedBy = ["multi-user.target"];
    requires = ["network-online.target"];
    after = ["network-online.target"];
    script = ''
      mkdir ${cfg.path}
      cd ${cfg.path}
      git init
      git config receive.denyCurrentBranch updateInstead
      chown -R ${cfg.user} .git
    '';
    serviceConfig.Type = "oneshot";
  };

  mkDeployService = name: cfg: {
    wantedBy = ["multi-user.target"];
    requires = ["network-online.target"];
    after = ["network-online.target"];
    user = cfg.user;

    serviceConfig = {
      Type = "simple";
      ExecStart = pkgs.writeScript "start" pkg.start;
      ExecStop = pkgs.writeScript "stop" pkg.stop;
      Restart = "always";
    };
  };

  mkWatchService = name: cfg: {
    wantedBy = ["multi-user.target"];
    requires = ["network-online.target"];
    after = ["network-online.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemctl}/bin/systemctl restart git-deploy.service";
    };
  };

  mkWatchPath = name: cfg: {
    wantedBy = ["multi-user.target"];

    pathConfig = {
      PathModified = cfg.path;
    };
  };
in
{
  options.services.git-deploy = mkOption {
    default = {};
    type = types.attrsOf (types.submodule gitDeploy);
    description = "Git based deployment";
  };

  config = mkIf (cfg != {}) {
    environment.systemPackages = [pkgs.git];

    users.users = mapAttrs' (name: cfg: nameValuePair name (mkUser cfg)) cfg;

    systemd = let
      create = prefix: f: mapAttrs' (name: cfg: nameValuePair "git-deploy-${prefix}-${name}" (f name cfg));
    in
    {
      services = create "setup" mkSetupService cfg ++ # XXX: This cloud be a reader monad refactor?
                 create "deploy" mkDeployService cfg ++
                 create "watch" mkWatchService cfg;

      paths = create "watch" mkWatchPath cfg;
    };
  };
}

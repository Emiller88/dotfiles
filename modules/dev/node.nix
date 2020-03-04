# modules/dev/node.nix --- https://nodejs.org/en/

{ pkgs, ... }: {
  imports = [ ./. ];

  my = {
    packages = with pkgs; [
      nodejs-12_x
      python27 # For building node-gyp
      solc
      (yarn.override { nodejs = pkgs.nodejs-12_x; })
    ];

    env.NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/config";
    env.NPM_CONFIG_CACHE = "$XDG_CACHE_HOME/npm";
    env.NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    env.NPM_CONFIG_PREFIX = "$XDG_CACHE_HOME/npm";
    env.NODE_REPL_HISTORY = "$XDG_CACHE_HOME/node/repl_history";
    env.PATH = [ "$(yarn global bin)" ];

    # Run locally installed bin-script, e.g. n coffee file.coffee
    alias.n = ''PATH="$(npm bin):$PATH"'';
    alias.ya = "yarn";
    alias.yart = "yarn dev || yarn start";

    home.xdg.configFile."npm/config".text = ''
      cache=$XDG_CACHE_HOME/npm
      prefix=$XDG_DATA_HOME/npm
    '';
  };
}

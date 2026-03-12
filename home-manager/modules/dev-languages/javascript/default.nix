{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {

    git.ignores = [
      "node_modules/"
      "bun.lockb"
      ".pnpm-debug.log*"
      ".yarn/install-state.gz"
      ".yarn/cache"
      ".yarn/build-state.yml"
      ".next/"
      ".nuxt/"
      ".output/"
      ".vercel/"
      ".netlify/"
      ".env"
      ".env.local"
      ".env.development.local"
      ".env.test.local"
      ".env.production.local"
      "logs"
      "npm-debug.log*"
      "yarn-debug.log*"
      "yarn-error.log*"
      "pids"
      "*.pid"
      "*.seed"
      "*.pid.lock"
      "coverage/"
      "*.lcov"
      ".nyc_output"
      "jspm_packages/"
      ".npm"
      ".eslintcache"
      ".rpt2_cache/"
      ".rts2_cache_cjs/"
      ".rts2_cache_es/"
      ".rts2_cache_umd/"
      ".node_repl_history"
      "*.tgz"
      ".yarn-integrity"
      ".parcel-cache"
      ".storybook-out"
      "tmp/"
      "temp/"
      "*.swo"
      "*~"
    ];
  };

  home = {
    packages = with pkgs; [
      nodejs
      pnpm
      yarn
      typescript-language-server
      vscode-langservers-extracted
      emmet-language-server
      eslint
      eslint_d
      esbuild
      live-server
      http-server
      np
    ];

    sessionVariables = {
      NODE_ENV = "development";
      NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
      PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
      SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      NODE_EXTRA_CA_CERTS = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      COREPACK_ENABLE_AUTO_PIN = "1";
      COREPACK_DEFAULT_TO_LATEST = "0";
    };

    sessionPath = [
      "${config.home.homeDirectory}/.npm-global/bin"
      "${config.home.homeDirectory}/.local/share/pnpm"
    ];

  };
}

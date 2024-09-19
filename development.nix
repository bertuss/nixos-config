{ config, pkgs, ...}: 
let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in {

   nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: with pkgs; {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  
  environment.systemPackages = with pkgs; [ 
    # compilers & interpreters
    libgcc
    gcc
    go
    cargo
    rustc
    nodejs
    python3
    lua
  
    #lsp
    lua-language-server
    gopls
    nodePackages.graphql-language-service-cli
    
    # utilities
    gnumake
    git
    fzf
    just
    xsv
    yq-go
    jq
    jqp
    ripgrep
    bruno
    redisinsight

    # go 
    air

    # python
    black
  
    # apps	
    google-chrome
    slack 
    obsidian	
    alacritty
    kitty
    vscode
    unstable.neovim
    zellij
    helix

    # cloud
    awscli2
    awsume

    kubectl
    k9s
    kubie
    kubernetes-helm
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

}

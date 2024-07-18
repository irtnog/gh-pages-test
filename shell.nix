with import <nixpkgs> {};

let
  gems = pkgs.bundlerEnv {
    name = "jekyll-gems";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in stdenv.mkDerivation {
  NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [
    stdenv.cc.cc
    openssl
    # ...
  ];
  NIX_LD = lib.fileContents "${stdenv.cc}/nix-support/dynamic-linker";
  name = "jekyll_env";
  src = "./";
  buildInputs = [
    bundler
    gems
    ruby
    bundix
    jekyll
    dart-sass
  ];
  shellHook = ''
    exec bundle exec jekyll serve --watch
  '';
}

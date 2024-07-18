with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "jekyll_env";
  buildInputs = [
    jekyll
    dart-sass
  ];
  shellHook = ''
    exec jekyll serve --watch
  '';
}

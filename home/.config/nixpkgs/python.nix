{ pkgs, ... }:

python3.withPackages (ps: with ps; [ numpy toolz ])

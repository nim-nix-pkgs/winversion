{
  description = ''This package allows you to determine the running version of the Windows operating system.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."winversion-master".dir   = "master";
  inputs."winversion-master".owner = "nim-nix-pkgs";
  inputs."winversion-master".ref   = "master";
  inputs."winversion-master".repo  = "winversion";
  inputs."winversion-master".type  = "github";
  inputs."winversion-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."winversion-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}
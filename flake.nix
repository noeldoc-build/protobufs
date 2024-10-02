# 🐻‍❄️🍯 noeldoc/protobufs: Contains the Protocol Buffers files for Noeldoc systems
# Copyright 2024 Noelware, LLC. <team@noelware.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http:#www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
{
  description = "🐻‍❄️🍯 Contains the Protocol Buffers files for Noeldoc systems";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    systems,
    ...
  }: let
    forEachSystem = nixpkgs.lib.genAttrs (import systems);
    nixpkgsFor = system:
      import nixpkgs {
        inherit system;
      };
  in {
    formatter = forEachSystem (system: (nixpkgsFor system).alejandra);
    devShells = forEachSystem (system: let
      pkgs = nixpkgsFor system;
    in {
      default = import ./nix/devshell.nix {inherit pkgs;};
    });
  };
}

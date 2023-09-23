{
  description = "cog25's NixOS Flakes";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    extra-substituters = [
      # Nix community's cache server
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      # `inputs` 내의 `follows` 키워드는 상속을 위해 사용됩니다.
      # 여기서는 `home-manager`의 `inputs.nixpkgs`가 현재 플레이크의 `inputs.nixpkgs`와 일치하도록 유지됩니다.
      # 서로 다른 버전의 nixpkgs에서 발생하는 문제를 피
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # `outputs`는 플레이크의 모든 빌드 결과입니다.
  #
  # 플레이크는 다양한 용도와 다양한 유형의 출력을 가질 수 있습니다.
  # 
  # 함수 `outputs`의 매개변수는 `inputs`에서 정의되며
  # 그들의 이름을 사용하여 참조할 수 있습니다. 그러나 `self`는 예외로
  # 이 특별한 매개변수는 `outputs` 자체를 가리킵니다(자기 참조).
  # 
  # 여기서 `@` 구문은 `inputs`의 매개변수의 속성 세트를 별칭(alias)으로 사용하여
  # 함수 내에서 편리하게 사용할 수 있도록 합니다.
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      # 기본적으로 NixOS는 호스트 이름을 사용하여 nixosConfiguration을 참조하려고 시도합니다.
      # 따라서 시스템 이름이 `nixos-test`인 경우 이 구성을 사용합니다.
      # 그러나 구성 이름은 다음과 같이 지정할 수도 있습니다:
      #   sudo nixos-rebuild switch --flake /경로/투/플레이크/디렉토리#<이름>
      #
      # `nixpkgs.lib.nixosSystem` 함수는 이 구성을 빌드하기 위해 사용됩니다.
      # 다음 속성 세트는 해당 함수의 매개변수입니다.
      #
      # 이 구성을 NixOS 시스템에 배포하려면 플레이크의 디렉토리에서 다음 명령을 실행하세요:
      #   sudo nixos-rebuild switch --flake .#nixos-test
      "zenbook" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        # Nix 모듈 시스템은 구성의 유지 관리를 개선하기 위해 구성을 모듈화할 수 있습니다.
        #
        # `modules`의 각 매개변수는 Nix 모듈이며
        # nixpkgs 메뉴얼에서 간략하게 소개되어 있습니다:
        #    <https://nixos.org/manual/nixpkgs/unstable/#module-system-introduction>
        # 메뉴얼은 불완전한 설명이며 몇 가지 간단한 소개만 포함되어 있습니다.
        # 현재 Nix 문서의 상태입니다...
        #
        # Nix 모듈은 속성 세트이거나 속성 세트를 반환하는 함수일 수 있습니다. 기본적으로
        # Nix 모듈이 함수인 경우 이 함수에는 다음 매개변수만 사용할 수 있습니다:
        #
        #  lib:         nixpkgs의 함수 라이브러리로 Nix 표현식 조작에 많은 유용한 함수를 제공합니다.
        #               https://nixos.org/manual/nixpkgs/stable/#id-1.4
        #  config:      현재 플레이크의 모든 구성 옵션입니다. 모든 유용한
        #  options:     현재 플레이크의 모든 NixOS 모듈에서 정의한 옵션입니다.
        #               내부 모듈에서 정의한 모든 옵션을 사용할 수 있습니다.
        #  pkgs:        nixpkgs에서 정의한 모든 패키지 모음과 패키지 관련 함수 세트입니다.
        #               현재는 주로 `nixpkgs.legacyPackages."${system}"`로 가정할 수 있습니다.
        #               `nixpkgs.pkgs` 옵션을 사용하여 사용자 정의할 수 있습니다.
        #  modulesPath: nixpkgs 모듈 폴더의 기본 경로입니다.
        #               추가 모듈을 nixpkgs에서 가져오는 데 사용됩니다.
        #               이 매개변수는 거의 사용되지 않으며
        #               현재는 무시해도 됩니다.
        #
        # 기본적으로 이러한 매개변수만 전달할 수 있습니다.
        # 다른 매개변수를 전달해야 하는 경우 다음 줄을 주석 해제하고
        # `specialArgs`를 사용해야 합니다:
        #
        # specialArgs = {...}  # 모든 하위 모듈로 사용자 정의 인수 전달
        modules = [
          # 여기에서 configuration.nix를 가져와서
          # 이전 구성 파일이 여전히 적용되도록 합니다.
          # 참고: configuration.nix 자체도 Nix 모듈입니다.
          ./configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO replace ryan with your own username
            home-manager.users.cog25 = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}

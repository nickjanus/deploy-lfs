with import <nixpkgs> {};
let
  config = import ./config.nix;
  terraform = stdenv.mkDerivation {
    name = "terraform";
    src = fetchzip {
      url = "https://releases.hashicorp.com/terraform/0.11.0/terraform_0.11.0_linux_amd64.zip";
      sha256 = "0c0h986vxb1wb489r86wi0aj9gp0vf3vn4vjib096is3jqa521xj";
    };
    installPhase = ''
      mkdir -p $out/bin
      cp terraform $out/bin
    '';
  };
  terraform_command = command : ''
    "terraform ${command} \
      -var 'do_token=${config.do_access_token}' \
      -var 'pub_key=${config.public_key}' \
      -var 'pvt_key=${config.private_key}' \
      -var 'spaces_key=${config.spaces_key}' \
      -var 'spaces_secret=${config.spaces_secret}' \
      -var 'ssh_fingerprint=${config.ssh_fingerprint}' \
      -var 'lfs_space=${config.lfs_space}'"
  '';
in
stdenv.mkDerivation {
  name = "dev-environment";

  buildInputs = [ terraform ];

  shellHook = ''
    # These must be configured for the S3 backend
    export AWS_ACCESS_KEY_ID="${config.spaces_key}"
    export AWS_SECRET_ACCESS_KEY="${config.spaces_secret}"
    export AWS_DEFAULT_REGION="us-east-1"

    alias tplan=${terraform_command("plan")}
    alias tapply=${terraform_command("apply")}
  '';
}

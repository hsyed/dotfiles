{ pkgs, ... }:
let
  # k9s resolves its config dir via XDG, which is Application Support on darwin.
  jumpsFile =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Application Support/k9s/jumps.yaml"
    else
      ".config/k9s/jumps.yaml";
in
{
  home.packages = [ pkgs.k9s ];

  home.file.${jumpsFile}.text = ''
    jumps:
      "apps.kruise.io/v1beta1/statefulsets":
        targetGVR: "v1/pods"
        labelSelector: "{{.status.labelSelector}}"
      "apps.kruise.io/v1alpha1/clonesets":
        targetGVR: "v1/pods"
        labelSelector: "{{.status.labelSelector}}"
  '';
}

# {

#   pkgs,
#   ...
# }:

# {
#   home = {
#     packages = with pkgs; [
#       android-tools
#     ];

#     sessionVariables = {
#       ANDROID_SDK_ROOT = "${pkgs.android-tools}/libexec/android-sdk";
#       ANDROID_HOME = "${pkgs.android-tools}/libexec/android-sdk";
#     };
#   };
# }

{ pkgs, ... }:

let
  androidSdk = pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "34" ];
    buildToolsVersions = [ "34.0.0" ];
    abiVersions = [ "x86_64" ];
  };
in
{
  home = {
    packages = [
      androidSdk.androidsdk
    ];

    sessionVariables = {
      ANDROID_HOME = "${androidSdk.androidsdk}/libexec/android-sdk";
      ANDROID_SDK_ROOT = "${androidSdk.androidsdk}/libexec/android-sdk";
    };
  };
}

{
  pkgs,
  ...
}:

{
  home = {
    packages = with pkgs; [
      supabase-cli
    ];
  };
}

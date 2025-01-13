{
  fetchFromGitHub,
  lib,
  nix-update-script,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "delink";
  version = "0-unstable-2025-01-08";

  src = fetchFromGitHub {
    owner = "devttys0";
    repo = "delink";
    rev = "988c1eea4b3659effb4500f9b655f0d984f65564";
    hash = "sha256-DayBwflmlopc24A9Cl1Vay6c+l/4MJwR2g9fc8ut8Wk=";
  };

  cargoHash = "sha256-0agBWBYaq+W8kz0LMy4mw7uH0+HxtUJ9cg8lBqViwtg=";

  passthru.updateScript = nix-update-script { extraArgs = [ "--version=branch" ]; };

  meta = {
    description = "Crypto library to decrypt various encrypted D-Link firmware images";
    homepage = "https://github.com/devttys0/delink";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [ KSJ2000 ];
    mainProgram = "delink";
  };
}

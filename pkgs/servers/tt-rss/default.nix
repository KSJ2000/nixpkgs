{
  lib,
  stdenv,
  fetchgit,
  nixosTests,
  unstableGitUpdater,
}:

stdenv.mkDerivation rec {
  pname = "tt-rss";
  version = "0-unstable-2025-02-08";

  src = fetchgit {
    url = "https://git.tt-rss.org/fox/tt-rss.git";
    rev = "169ff6de341b20803796298d8ffea3ee4c4c4f09";
    hash = "sha256-gMQSHRSb+p+SBKSN1Y4RLpHBIvq+Zq+/tX+GWktBy1g=";
  };

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -ra * $out/

    # see the code of Config::get_version(). you can check that the version in
    # the footer of the preferences pages is not UNKNOWN
    echo "${version}" > $out/version_static.txt

    runHook postInstall
  '';

  passthru = {
    inherit (nixosTests) tt-rss;
    updateScript = unstableGitUpdater { hardcodeZeroVersion = true; };
  };

  meta = with lib; {
    description = "Web-based news feed (RSS/Atom) aggregator";
    license = licenses.gpl2Plus;
    homepage = "https://tt-rss.org";
    maintainers = with maintainers; [
      gileri
      globin
      zohl
    ];
    platforms = platforms.all;
  };
}

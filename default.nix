with (import <nixpkgs> {});

let version = "0.9.11.7.803-87d0708"; in

stdenv.mkDerivation {
  name = "plexmediaserver-${version}";

  builder = ./builder.sh;

  src = fetchurl {
    url = "https://downloads.plex.tv/plex-media-server/0.9.11.7.803-87d0708/plexmediaserver_0.9.11.7.803-87d0708_amd64.deb";
    sha256 = "0wsj70lq3dswy8d3hy1frfrw1fnrs4s8mnhqvayym042c2s6vbxj";
  };

  meta = {
    description = "Plex Media Server";
    homepage = https://plex.tv/;
    license = stdenv.lib.licenses.unfree;
  };
}

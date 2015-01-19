source $stdenv/setup

echo "Unpacking .deb file"
ar x $src
mkdir data
mkdir control
tar -xzf data.tar.gz -C data
tar -xzf control.tar.gz -C control

echo "Preparing files for installation"
rm -R data/etc/init
mkdir data/etc/plex
mv data/etc/default/plexmediaserver data/etc/plex/plexmediaserver.conf
rm -R data/etc/default

mkdir -p $out/lib
cp -r data/usr/lib/plexmediaserver $out/lib/plexmediaserver

mkdir -p $out/bin

patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
    $out/lib/plexmediaserver/Plex\ Media\ Server

patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
    $out/lib/plexmediaserver/Plex\ DLNA\ Server

patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
    $out/lib/plexmediaserver/Plex\ Media\ Scanner

patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
    $out/lib/plexmediaserver/Resources/rsync

patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
    $out/lib/plexmediaserver/Resources/Python/bin/python

substitute data/usr/sbin/start_pms $out/bin/start_pms \
    --replace /usr/lib/plexmediaserver $out/lib/plexmediaserver \
    --replace /etc/default/plexmediaserver /etc/plex/plexmediaserver.conf

chmod a+x $out/bin/start_pms

nix-push --url-prefix http://plug.grambo.me.uk/plexmediaserver --manifest --dest /tmp/cache $(nix-build default.nix)
mkdir -p channel
tar --xz -cf channel/nixexprs.tar.xz default.nix builder.sh
cp /tmp/cache/MANIFEST.bz2 channel

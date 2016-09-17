cat > "$ROOTFS/etc/apt/sources.list" <<EOF
deb http://httpredir.debian.org/debian ${RELEASE} main contrib non-free
deb http://httpredir.debian.org/debian ${RELEASE}-updates main contrib non-free
deb http://security.debian.org ${RELEASE}/updates main contrib non-free
EOF

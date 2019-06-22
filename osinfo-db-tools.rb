class OsinfoDbTools < Formula
  desc "Tools for managing the libosinfo database files"
  homepage "https://libosinfo.org"
  url "https://releases.pagure.org/libosinfo/osinfo-db-tools-1.5.0.tar.gz"
  sha256 "f43160f3f3251849f8b8b37c84ad8640f2a51937d8ea38626f14aa2a159730de"

  depends_on "pkg-config" => :build

  depends_on "gettext"
  depends_on "glib"
  depends_on "json-glib"
  depends_on "libarchive" # need >= 3.0.0

  def install
    # sh lives at /bin/sh on macOS, not /usr/bin/sh
    inreplace "build-aux/install-sh", "#!/usr/bin/sh", "#!/bin/sh"

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --prefix=#{prefix}
      --localstatedir=#{var}
      --sysconfdir=#{etc}
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/osinfo-db-path"
  end
end

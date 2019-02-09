class OsinfoDbTools < Formula
  desc "Tools for managing the libosinfo database files"
  homepage "https://libosinfo.org"
  url "https://releases.pagure.org/libosinfo/osinfo-db-tools-1.3.0.tar.gz"
  sha256 "6e49bd94a9fb6fe371337e5a91a7e4ed6f370b2ca70385e0cab38d58ad7f07fa"

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build

  depends_on "gettext"
  depends_on "glib"
  depends_on "json-glib"
  depends_on "libarchive" # need >= 3.0.0

  def install
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

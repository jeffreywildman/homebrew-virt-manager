class OsinfoDbTools < Formula
  desc "Tools for managing the libosinfo database files"
  homepage "https://libosinfo.org"
  url "https://releases.pagure.org/libosinfo/osinfo-db-tools-1.4.0.tar.gz"
  sha256 "7ee0125c6b99b5b9e10d9bf5951ecc8a170278499a778e6be5c61ef10296f723"

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

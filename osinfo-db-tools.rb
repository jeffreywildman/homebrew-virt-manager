class OsinfoDbTools < Formula
  desc "Tools for managing the libosinfo database files"
  homepage "https://libosinfo.org"
  url "https://releases.pagure.org/libosinfo/osinfo-db-tools-1.2.0.tar.gz"
  sha256 "3b50829e5b58db15fe9fc8caf005aa18300262fea4562da0c2dfbe56355ff81f"
  revision 1

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build

  depends_on "gettext"
  depends_on "glib"
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

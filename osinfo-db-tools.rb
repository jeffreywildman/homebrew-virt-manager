class OsinfoDbTools < Formula
  desc "Tools for managing the libosinfo database files"
  homepage "https://libosinfo.org"
  url "https://releases.pagure.org/libosinfo/osinfo-db-tools-1.9.0.tar.xz"
  sha256 "255f1c878bacec70c3020ff5a9cb0f6bd861ca0009f24608df5ef6f62d5243c0"
  revision 1

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "glib"
  depends_on "json-glib"
  depends_on "libarchive"
  depends_on "libxml2"
  depends_on "libsoup"

  def install
    flags = %W[
      -Dsysconfdir=#{etc}
    ]
    system "meson", "setup", "builddir", *std_meson_args, *flags
    system "ninja", "-C", "builddir", "install", "-v"
  end

  test do
    system "#{bin}/osinfo-db-path"
  end
end

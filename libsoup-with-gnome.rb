class LibsoupWithGnome < Formula
  desc "HTTP client/server library for GNOME"
  homepage "https://live.gnome.org/LibSoup"
  url "https://download.gnome.org/sources/libsoup/2.53/libsoup-2.53.2.tar.xz"
  sha256 "6d36c9924a517a4e455760d4c15995ef3b0d653693f5be99e56fd6fd23dfc413"

  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "vala" => :build

  depends_on "glib-networking"
  depends_on "gnutls"
  depends_on "sqlite"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--disable-tls-check"
    system "make", "install"
  end
end

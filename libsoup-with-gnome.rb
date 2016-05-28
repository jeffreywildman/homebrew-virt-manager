class LibsoupWithGnome < Formula
  desc "HTTP client/server library for GNOME"
  homepage "https://live.gnome.org/LibSoup"
  url "https://download.gnome.org/sources/libsoup/2.54/libsoup-2.54.1.tar.xz"
  sha256 "47b42c232034734d66e5f093025843a5d8cc4b2357c011085a2fd04ef02dd633"

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

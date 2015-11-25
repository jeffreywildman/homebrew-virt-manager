class LibsoupWithGnome < Formula
  desc "HTTP client/server library for GNOME"
  homepage "https://live.gnome.org/LibSoup"
  url "https://download.gnome.org/sources/libsoup/2.52/libsoup-2.52.2.tar.xz"
  sha256 "db55628b5c7d952945bb71b236469057c8dfb8dea0c271513579c6273c2093dc"

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

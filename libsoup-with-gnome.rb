class LibsoupWithGnome < Formula
  desc "HTTP client/server library for GNOME"
  homepage "https://live.gnome.org/LibSoup"
  url "https://download.gnome.org/sources/libsoup/2.54/libsoup-2.54.0.1.tar.xz"
  sha256 "ade4920166bd036e8890d04acdc135686d877670953949fa6245797c906e38e0"

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

class LibsoupWithGnome < Formula
  desc "HTTP client/server library for GNOME"
  homepage "https://live.gnome.org/LibSoup"
  url "https://download.gnome.org/sources/libsoup/2.52/libsoup-2.52.0.tar.xz"
  sha256 "6c6c366622a1a9d938e0cea9b557fa536f088784251d31381ccd1b115a466785"

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

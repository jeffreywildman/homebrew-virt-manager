class SpiceGtk < Formula
  desc "GTK client/libraries for SPICE"
  homepage "http://www.spice-space.org/home.html"
  url "http://www.spice-space.org/download/gtk/spice-gtk-0.31.tar.bz2"
  sha256 "c72b4d202b1c0b71d6e24ce5caf914d6dddbcf4010d10db9c2d8e73af728c1ca"

  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vala" => :build

  depends_on "cairo"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "jpeg"
  depends_on "openssl"
  depends_on "pango"
  depends_on "pixman"
  depends_on "spice-protocol"
  depends_on "usbredir"
  # TODO: audio

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-gtk=3.0",
                          "--enable-introspection",
                          "--enable-vala",
                          "--with-audio=no",
                          "--with-coroutine=gthread",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

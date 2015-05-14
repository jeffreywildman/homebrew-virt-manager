class SpiceGtk < Formula
  homepage "http://www.spice-space.org/home.html"
  url "http://www.spice-space.org/download/gtk/spice-gtk-0.28.tar.bz2"
  sha256 "15aeeb63422cb3bfaa2edbf4602ed2025baa4455abfd1677f631245a0d0f81c4"

  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "vala" => :build

  depends_on "cairo"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "jpeg"
  depends_on "pango"
  depends_on "pixman"
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

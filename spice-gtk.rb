class SpiceGtk < Formula
  homepage "http://www.spice-space.org/home.html"
  url "http://www.spice-space.org/download/gtk/spice-gtk-0.29.tar.bz2"
  sha256 "44c7e22713246a2054c3c3b6e0280fd4c1fdbd2c8d33e5eb95bcda4748d5e973"

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

class SpiceGtk < Formula
  homepage "http://www.spice-space.org/home.html"
  url "http://www.spice-space.org/download/gtk/spice-gtk-0.26.tar.bz2"
  sha256 "d61cabeb4ae03afb5bb921139491d1088ca0cdf77c7e70b8039fe62c2246e3f9"

  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "vala" => :build

  depends_on "cairo"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "jpeg"
  depends_on "pango"
  depends_on "pixman"
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

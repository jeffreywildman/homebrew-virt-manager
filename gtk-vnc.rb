class GtkVnc < Formula
  homepage "https://wiki.gnome.org/Projects/gtk-vnc"
  url "https://download.gnome.org/sources/gtk-vnc/0.5/gtk-vnc-0.5.3.tar.xz"
  sha1 "37545223e944d7083d5ae5b945431d8d14eddd47"

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  #depends_on "vala" => :build
  depends_on "gobject-introspection" => :build

  depends_on "gtk+3"
  depends_on "gnutls"
  #depends_on "glib"
  #depends_on :x11 # if your formula requires any X11/XQuartz components

  # TODO: audio?
  #depends_on "pulseaudio"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-gtk=3.0",
                          "--disable-vala",
                          "--enable-introspection",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

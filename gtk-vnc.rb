class GtkVnc < Formula
  desc "VNC viewer widget for GTK"
  homepage "https://wiki.gnome.org/Projects/gtk-vnc"
  url "https://download.gnome.org/sources/gtk-vnc/0.5/gtk-vnc-0.5.4.tar.xz"
  sha256 "488aa97a76ce6868160699cd45d4a0ee0fe6f0ad4631737c6ddd84450f6c9ce7"

  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "vala" => :build

  depends_on "atk"
  depends_on "cairo"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gnutls"
  depends_on "gtk+3"
  depends_on "libgcrypt"
  depends_on "libgpg-error"
  depends_on "pango"
  # TODO: sound
  # depends_on "pulseaudio"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-gtk=3.0",
                          "--enable-introspection",
                          "--with-coroutine=gthread",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

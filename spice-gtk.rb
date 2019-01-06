class SpiceGtk < Formula
  desc "GTK client/libraries for SPICE"
  homepage "https://www.spice-space.org"
  url "https://www.spice-space.org/download/gtk/spice-gtk-0.35.tar.bz2"
  sha256 "b4e6073de5125e2bdecdf1fbe7c9e8c4cabe9c85518889b42f72bf63c8ab9e86"
  revision 1

  depends_on "autoconf" => :build
  depends_on "autogen" => :build
  depends_on "automake" => :build
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
  depends_on "gst-libav"
  depends_on "gst-plugins-bad"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-good"
  depends_on "gst-plugins-ugly"
  depends_on "gstreamer"
  depends_on "gtk+3"
  depends_on "jpeg"
  depends_on "libusb"
  depends_on "lz4"
  depends_on "openssl"
  depends_on "opus"
  depends_on "pango"
  depends_on "pixman"
  depends_on "spice-protocol"
  depends_on "usbredir"

  def install
    # Some files (vncdisplaykeymap.c) require building as Objective-C
    # https://www.mail-archive.com/spice-devel@lists.freedesktop.org/msg40085.html
    ENV["CFLAGS"] = "-ObjC -g -O2"

    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-introspection
      --enable-gstvideo
      --enable-gstaudio
      --enable-gstreamer=1.0
      --enable-vala
      --with-coroutine=gthread
      --with-gtk=3.0
      --with-lz4
      --prefix=#{prefix}
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <spice-client.h>
      #include <spice-client-gtk.h>
      int main() {
        return spice_session_new() ? 0 : 1;
      }
    EOS
    system ENV.cc, "test.cpp",
                   "-I#{Formula["spice-protocol"].include}/spice-1",
                   "-I#{Formula["glib"].include}/glib-2.0",
                   "-I#{Formula["glib"].lib}/glib-2.0/include",
                   "-I#{Formula["atk"].include}/atk-1.0",
                   "-I#{Formula["gdk-pixbuf"].include}/gdk-pixbuf-2.0",
                   "-I#{Formula["cairo"].include}/cairo",
                   "-I#{Formula["pango"].include}/pango-1.0",
                   "-I#{Formula["gtk+3"].include}/gtk-3.0",
                   "-I#{include}/spice-client-glib-2.0",
                   "-I#{include}/spice-client-gtk-3.0",
                   "-L#{lib}",
                   "-lspice-client-glib-2.0",
                   "-lspice-client-gtk-3.0",
                   "-o", "test"
    system "./test"
  end
end

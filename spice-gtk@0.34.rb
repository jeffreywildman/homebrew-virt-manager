class SpiceGtkAT034 < Formula
  desc "GTK client/libraries for SPICE"
  homepage "https://www.spice-space.org"
  url "https://www.spice-space.org/download/gtk/spice-gtk-0.34.tar.bz2"
  sha256 "e9720e01165f8451c9f3f58ad50e3afb990993b81cc2db86b3661b7ac5b976ee"

  depends_on "autoconf" => :build
  depends_on "autogen" => :build
  depends_on "automake" => :build
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
  depends_on "lz4"
  depends_on "openssl"
  depends_on "pango"
  depends_on "pixman"
  depends_on "spice-protocol"
  depends_on "usbredir"

  # for --enable-gst(audio|video)
  depends_on "gstreamer"
  depends_on "gst-libav"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-good"
  depends_on "gst-plugins-bad"
  depends_on "gst-plugins-ugly"

  # compile vncdisplaykeymap.c as objc to fix include issue
  patch :DATA

  def install
    ENV["CFLAGS"] = "-Wno-cast-align -Wno-error"
    ENV["XML_CATALOG_FILES"] = "/usr/local/etc/xml/catalog"

    mv "src/vncdisplaykeymap.c", "src/vncdisplaykeymap.m"

    system "autoreconf", "-v", "--force", "--install"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--with-gtk=3.0",
                          "--enable-introspection",
                          "--enable-vala",
                          "--enable-gstvideo",
                          "--enable-gstaudio",
                          "--enable-gstreamer=1.0",
                          "--with-lz4",
                          "--with-coroutine=gthread",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
__END__
diff --git a/configure.ac b/configure.ac
index f915d81..10ef73d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -25,6 +25,7 @@ AC_SUBST(SPICE_GTK_LOCALEDIR)
 
 GTK_DOC_CHECK([1.14],[--flavour no-tmpl])
 
+AC_PROG_OBJC
 AC_PROG_CC
 AC_PROG_CC_C99
 if test "x$ac_cv_prog_cc_c99" = xno; then
diff --git a/src/Makefile.am b/src/Makefile.am
index 5430d84..dad3fa5 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -125,7 +125,7 @@ SPICE_GTK_SOURCES_COMMON =		\
 	spice-widget.c			\
 	spice-widget-priv.h		\
 	spice-file-transfer-task.h \
-	vncdisplaykeymap.c		\
+	vncdisplaykeymap.m		\
 	vncdisplaykeymap.h		\
 	spice-grabsequence.c		\
 	spice-grabsequence.h		\
@@ -481,7 +481,7 @@ spice-widget-enums.h: spice-widget.h
 		$< >  $@
 
 
-vncdisplaykeymap.c: $(KEYMAPS)
+vncdisplaykeymap.m: $(KEYMAPS)
 $(KEYMAPS): $(srcdir)/$(KEYMAP_GEN) $(srcdir)/$(KEYMAP_CSV)
 
 vncdisplaykeymap_xorgevdev2xtkbd.c:
diff --git a/spice-common/m4/spice-deps.m4 b/spice-common/m4/spice-deps.m4
index 68e3091..2e4c305 100644
--- a/spice-common/m4/spice-deps.m4
+++ b/spice-common/m4/spice-deps.m4
@@ -1,10 +1,3 @@
-# For autoconf < 2.63
-m4_ifndef([AS_VAR_APPEND],
-          AC_DEFUN([AS_VAR_APPEND], $1=$$1$2))
-m4_ifndef([AS_VAR_COPY],
-          [m4_define([AS_VAR_COPY],
-          [AS_LITERAL_IF([$1[]$2], [$1=$$2], [eval $1=\$$2])])])
-
 
 # SPICE_WARNING(warning)
 # SPICE_PRINT_MESSAGES

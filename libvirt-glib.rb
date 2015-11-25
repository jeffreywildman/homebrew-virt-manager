class LibvirtGlib < Formula
  homepage "https://libvirt.org/"
  url "https://libvirt.org/sources/glib/libvirt-glib-0.2.2.tar.gz"
  sha256 "d7be16025231c91ccae43838b7cdb1d55d181856a2a50b0f7b1c5078ad202d9d"

  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build

  depends_on "glib"
  depends_on "libvirt"
  depends_on "libxml2"

  patch :DATA # remove unsupported linker option: --version-script

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-introspection",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
__END__
diff --git a/libvirt-gconfig/Makefile.am b/libvirt-gconfig/Makefile.am
index a9a6591..ca83fca 100644
--- a/libvirt-gconfig/Makefile.am
+++ b/libvirt-gconfig/Makefile.am
@@ -213,8 +213,8 @@ libvirt_gconfig_1_0_la_DEPENDENCIES = \
 libvirt_gconfig_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-gconfig.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
+#			-Wl,--version-script=$(srcdir)/libvirt-gconfig.sym \

 BUILT_SOURCES = $(GCONFIG_GENERATED_FILES)

diff --git a/libvirt-gconfig/Makefile.in b/libvirt-gconfig/Makefile.in
index 42e4352..67d7fae 100644
--- a/libvirt-gconfig/Makefile.in
+++ b/libvirt-gconfig/Makefile.in
@@ -747,8 +747,8 @@ libvirt_gconfig_1_0_la_DEPENDENCIES = \
 libvirt_gconfig_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-gconfig.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
+#			-Wl,--version-script=$(srcdir)/libvirt-gconfig.sym \

 BUILT_SOURCES = $(GCONFIG_GENERATED_FILES)
 CLEANFILES = $(BUILT_SOURCES) $(am__append_2)
diff --git a/libvirt-glib/Makefile.am b/libvirt-glib/Makefile.am
index a48cfbb..d865a63 100644
--- a/libvirt-glib/Makefile.am
+++ b/libvirt-glib/Makefile.am
@@ -34,8 +34,8 @@ libvirt_glib_1_0_la_DEPENDENCIES = \
 libvirt_glib_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-glib.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
+#			-Wl,--version-script=$(srcdir)/libvirt-glib.sym \

 # .libs/libvirt-glib.so is built by libtool as a side-effect of the Makefile
 # rule for libosvirt-glib.la.  However, checking symbols relies on Linux ELF layout
diff --git a/libvirt-glib/Makefile.in b/libvirt-glib/Makefile.in
index 3523684..47c4417 100644
--- a/libvirt-glib/Makefile.in
+++ b/libvirt-glib/Makefile.in
@@ -436,8 +436,8 @@ libvirt_glib_1_0_la_DEPENDENCIES = \
 libvirt_glib_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-glib.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
+#			-Wl,--version-script=$(srcdir)/libvirt-glib.sym \

 INTROSPECTION_GIRS = $(am__append_1)
 CLEANFILES = $(am__append_2)
diff --git a/libvirt-gobject/Makefile.am b/libvirt-gobject/Makefile.am
index 7163c7d..8a379b0 100644
--- a/libvirt-gobject/Makefile.am
+++ b/libvirt-gobject/Makefile.am
@@ -90,8 +90,8 @@ libvirt_gobject_1_0_la_DEPENDENCIES = \
 libvirt_gobject_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-gobject.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
+#			-Wl,--version-script=$(srcdir)/libvirt-gobject.sym \

 libvirt-gobject-enums.c: $(libvirt_gobject_1_0_la_HEADERS)
 	$(AM_V_GEN)glib-mkenums \
diff --git a/libvirt-gobject/Makefile.in b/libvirt-gobject/Makefile.in
index 26e0df6..0ffa15c 100644
--- a/libvirt-gobject/Makefile.in
+++ b/libvirt-gobject/Makefile.in
@@ -520,8 +520,8 @@ libvirt_gobject_1_0_la_DEPENDENCIES = \
 libvirt_gobject_1_0_la_LDFLAGS = \
 			$(COVERAGE_CFLAGS:-f%=-Wc,f%) \
 			$(CYGWIN_EXTRA_LDFLAGS) $(MINGW_EXTRA_LDFLAGS) \
-			-Wl,--version-script=$(srcdir)/libvirt-gobject.sym \
 			-version-info $(LIBVIRT_GLIB_VERSION_INFO)
+#			-Wl,--version-script=$(srcdir)/libvirt-gobject.sym \

 BUILT_SOURCES = $(GOBJECT_GENERATED_FILES)
 CLEANFILES = $(BUILT_SOURCES) $(am__append_2)

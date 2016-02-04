class Libosinfo < Formula
  desc "The operating system information database"
  homepage "https://libosinfo.org/"
  url "https://fedorahosted.org/releases/l/i/libosinfo/libosinfo-0.3.0.tar.gz"
  sha256 "538a3468792e919edf5364fe102d751353ae600a92ad3a24f024424a182cefbc"

  depends_on "gobject-introspection" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "wget" => :build

  depends_on "check"
  depends_on "libsoup-with-gnome"
  depends_on "libxml2"

  patch :DATA # remove unknown linker option: --no-undefined

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-introspection",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
__END__
diff --git a/configure b/configure
index 01b764d..22f7d15 100755
--- a/configure
+++ b/configure
@@ -14694,7 +14694,7 @@ case "$host" in
     ;;

   *)
-    NO_UNDEFINED_FLAGS="-Wl,--no-undefined"
+    NO_UNDEFINED_FLAGS=""
     VERSION_SCRIPT_FLAGS=-Wl,--version-script=
     `ld --help 2>&1 | grep -- --version-script >/dev/null` || \
       VERSION_SCRIPT_FLAGS="-Wl,-M -Wl,"

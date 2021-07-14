class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-viewer/virt-viewer-10.0.tar.xz"
  sha256 "d23bc0a06e4027c37b8386cfd0286ef37bd738977153740ab1b6b331192389c5"
  revision 3

  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "desktop-file-utils"
  depends_on "glib"
  depends_on "gtk-vnc"
  depends_on "gtk+3"
  depends_on "libvirt-glib"
  depends_on "shared-mime-info"
  depends_on "spice-gtk"

  patch :DATA

  def install
    system "meson", "setup", "builddir", *std_meson_args
    system "ninja", "-C", "builddir", "install", "-v"
  end

  def post_install
    system Formula["shared-mime-info"].opt_bin/"update-mime-database", HOMEBREW_PREFIX/"share/mime"
    system Formula["gtk+3"].opt_bin/"gtk3-update-icon-cache", HOMEBREW_PREFIX/"share/icons/hicolor"
    system Formula["desktop-file-utils"].opt_bin/"update-desktop-database", HOMEBREW_PREFIX/"share/applications"
  end

  test do
    system bin/"virt-viewer", "--version"
  end
end
__END__
diff --git a/meson.build b/meson.build
index e5ed47b..26f386f 100644
--- a/meson.build
+++ b/meson.build
@@ -539,30 +539,6 @@ i18n = import('i18n')
 i18n_itsdir = join_paths(meson.source_root(), 'data', 'gettext')
 top_include_dir = [include_directories('.')]

-update_mime_database = find_program('update-mime-database', required: false)
-update_icon_cache = find_program('gtk-update-icon-cache', required: false)
-update_desktop_database = find_program('update-desktop-database', required: false)
-
-update_mime_database_path = ''
-if update_mime_database.found()
-  update_mime_database_path = update_mime_database.path()
-endif
-
-update_icon_cache_path = ''
-if update_icon_cache.found()
-  update_icon_cache_path = update_icon_cache.path()
-endif
-
-update_desktop_database_path = ''
-if update_desktop_database.found()
-  update_desktop_database_path = update_desktop_database.path()
-endif
-
-meson.add_install_script('build-aux/post_install.py',
-                         update_mime_database_path,
-                         update_icon_cache_path,
-                         update_desktop_database_path)
-
 subdir('icons')
 subdir('src')
 subdir('po')

class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://gitlab.com/virt-viewer/virt-viewer/-/archive/a634fa8d9fbc59b093f2f07110b2c867f622599d/virt-viewer-a634fa8d9fbc59b093f2f07110b2c867f622599d.tar.gz"
  sha256 "779d5b30f3231d39ce681c7fa6344cca5755fda0448164692d52e61f8724dc22"
  version "11.0+git20260805"

  head "https://gitlab.com/virt-viewer/virt-viewer.git", branch: "master"

  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build

  depends_on "desktop-file-utils"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "libvirt"
  depends_on "libvirt-glib"
  depends_on "shared-mime-info"
  depends_on "spice-gtk"

  # Upstream installs a post_install.py hook that regenerates mime/icon/desktop
  # caches inside the Cellar; those files collide with the prefix copies at
  # `brew link` time. Homebrew refreshes the caches in post_install instead.
  patch :DATA

  def install
    system "meson", "setup", "builddir", "-Dovirt=disabled", *std_meson_args
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
index 5f2649c..5293cdb 100644
--- a/meson.build
+++ b/meson.build
@@ -535,30 +535,6 @@ i18n = import('i18n')
 i18n_itsdir = join_paths(meson.project_source_root(), 'data', 'gettext')
 top_include_dir = [include_directories('.')]
 
-update_mime_database = find_program('update-mime-database', required: false)
-update_icon_cache = find_program('gtk-update-icon-cache', required: false)
-update_desktop_database = find_program('update-desktop-database', required: false)
-
-update_mime_database_path = ''
-if update_mime_database.found()
-  update_mime_database_path = update_mime_database.full_path()
-endif
-
-update_icon_cache_path = ''
-if update_icon_cache.found()
-  update_icon_cache_path = update_icon_cache.full_path()
-endif
-
-update_desktop_database_path = ''
-if update_desktop_database.found()
-  update_desktop_database_path = update_desktop_database.full_path()
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

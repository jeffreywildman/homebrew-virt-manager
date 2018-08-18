class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-viewer/virt-viewer-7.0.tar.gz"
  sha256 "47c2cfaa376f5f20968c0addfd65c62b90cab4e6336febf2bc44499d4cdcc903"

  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "hicolor-icon-theme"
  depends_on "libvirt"
  depends_on "libvirt-glib"
  depends_on "shared-mime-info"
  depends_on "spice-gtk"
  depends_on "spice-protocol"

  def install
    system "./configure", "--disable-silent-rules",
                          "--disable-update-mimedb",
                          "--with-gtk-vnc",
                          "--with-spice-gtk",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  def post_install
    # manual update of mime database
    system "#{Formula["shared-mime-info"].opt_bin}/update-mime-database", "#{HOMEBREW_PREFIX}/share/mime"
    # manual icon cache update step
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end
end

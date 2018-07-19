class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-viewer/virt-viewer-6.0.tar.gz"
  sha256 "9037bd7773da4dae761871ec1ab646cfefb4d7e48b1504dddf315a548ccb18b2"

  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "hicolor-icon-theme"
  depends_on "libvirt"
  depends_on "libvirt-glib"
  depends_on "shared-mime-info"
  depends_on "spice-gtk@0.34"
  depends_on "spice-protocol"

  def install
    system "./configure", "--disable-silent-rules",
                          "--disable-update-mimedb",
                          "--with-gtk-vnc",
                          "--with-spice-gtk",
                          "--with-gtk=3.0",
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

class VirtViewer < Formula
  desc "App for virtualized guest interaction"
  homepage "https://virt-manager.org/"
  url "https://fedorahosted.org/released/virt-viewer/virt-viewer-3.1.tar.gz"
  sha256 "be4e49470b650fc22513c2c01f2e13e30ee2d494d0d7b319b6f414ca781078c7"

  depends_on "intltool" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "hicolor-icon-theme"
  depends_on "libvirt"
  depends_on "shared-mime-info"
  depends_on "spice-gtk"
  depends_on "spice-protocol"
  depends_on :x11
  # TODO: audio

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-update-mimedb",
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

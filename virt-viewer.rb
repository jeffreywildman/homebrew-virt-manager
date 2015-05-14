class VirtViewer < Formula
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-viewer/virt-viewer-2.0.tar.gz"
  sha256 "e9c583bcb5acdabac6a8a13eff6ce4e093a3050645771628f832e15ce685d437"

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "libtool" => :build

  depends_on "gtk+3"
  depends_on :x11

  # TODO: audio
  depends_on "gtk-vnc"
  
  depends_on "spice-gtk"
  depends_on "spice-protocol"

  depends_on "libvirt"
  depends_on "hicolor-icon-theme"
  depends_on "shared-mime-info"

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
    system "#{Formula["gtk+"].opt_bin}/gtk-update-icon-cache", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end
end

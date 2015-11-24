class VirtViewer < Formula
  homepage "https://virt-manager.org/"
  url "https://github.com/SPICE/virt-viewer/archive/v2.0.tar.gz"
  sha256 "2aeb08d1ec53c4c9d8d3e4b8a8d43bdb011e20a1d746fec95f4f835b8cd85980"

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

 if MacOS.version >= :el_capitan
  # Fixes build on El Capitan
  # https://trac.macports.org/ticket/48471
  patch :p0 do
  url "https://trac.macports.org/raw-attachment/ticket/48471/define_non_standard_clang_macros.patch"
  sha256 "e727383c9186fdc36f804c69ad550f5cfd2b996e37083be94c0c9aa8fde226ee"
 end

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

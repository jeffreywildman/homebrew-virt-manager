class Usbredir < Formula
  desc "USB traffic redirection library"
  homepage "https://www.spice-space.org"
  url "https://www.spice-space.org/download/usbredir/usbredir-0.7.1.tar.bz2"
  sha256 "407e9e27a1369f01264d5501ffbe88935ddd7d5de675f5835db05dc9c9ac56f3"

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "libusb"

  def install
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

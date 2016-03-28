class SpiceProtocol < Formula
  desc "Headers for SPICE protocol"
  homepage "http://www.spice-space.org/"
  url "http://www.spice-space.org/download/releases/spice-protocol-0.12.11.tar.bz2"
  sha256 "22bae438bfb6c3245b195755c3f55e72c1f2bfae6f39c905b576fcb6c79b6330"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

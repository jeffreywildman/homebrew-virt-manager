class SpiceProtocol < Formula
  desc "Headers for SPICE protocol"
  homepage "http://www.spice-space.org/"
  url "http://www.spice-space.org/download/releases/spice-protocol-0.12.10.tar.bz2"
  sha256 "788f0d7195bec5b14371732b562eb55ca82712aab12273b0e87529fb30532efb"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

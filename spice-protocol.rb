class SpiceProtocol < Formula
  homepage "http://www.spice-space.org/"
  url "http://www.spice-space.org/download/releases/spice-protocol-0.12.8.tar.bz2"
  sha256 "116d57a1893c08f8f7801579dffb4c1568a4fb4566aa75c84a2685f150aae67c"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

class SpiceProtocol < Formula
  desc "Headers for SPICE protocol"
  homepage "https://www.spice-space.org/"
  url "https://www.spice-space.org/download/releases/spice-protocol-0.12.13.tar.bz2"
  sha256 "89ee11b202d2268e061788e6ace114e1ff18c7620ae64d1ca3aba252ee7c9933"

  def install
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

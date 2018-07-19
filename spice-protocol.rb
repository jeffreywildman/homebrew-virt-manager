class SpiceProtocol < Formula
  desc "Headers for SPICE protocol"
  homepage "https://www.spice-space.org/"
  url "https://www.spice-space.org/download/releases/spice-protocol-0.12.14.tar.bz2"
  sha256 "20350bc4309039fdf0d29ee4fd0033cde27bccf33501e13b3c1befafde9d0c9c"

  def install
    system "./configure", "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end

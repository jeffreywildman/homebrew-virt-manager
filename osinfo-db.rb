class OsinfoDb < Formula
  desc "Libosinfo database files"
  homepage "https://libosinfo.org/"
  url "https://releases.pagure.org/libosinfo/osinfo-db-20180720.tar.xz"
  sha256 "48c9047c35e9f6289c0dfe9238a039068eca6b026962e25bc2fa753e99fa0978"

  depends_on "osinfo-db-tools" => :build

  def install
    system "osinfo-db-import", "--local", cached_download

    # Copy the archive into the prefix to avoid empty installation error
    cp_r "./", prefix
  end

  test do
    system "#{bin}/osinfo-db-validate", "--local"
  end
end

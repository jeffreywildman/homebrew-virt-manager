class OsinfoDb < Formula
  desc "Libosinfo database files"
  homepage "https://libosinfo.org/"
  url "https://releases.pagure.org/libosinfo/osinfo-db-20181116.tar.xz"
  sha256 "e7e7623a621493e94bb13e6ebd456f1e278c77bebf390d3bf8f3dcadb3142d7c"

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

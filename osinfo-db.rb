class OsinfoDb < Formula
  desc "Libosinfo database files"
  homepage "https://libosinfo.org/"
  url "https://releases.pagure.org/libosinfo/osinfo-db-20181214.tar.xz"
  sha256 "8dc1e980c8e1d8c043c22c63b7db20e7b4b34a73dbe98b9d31536eb83929d5a3"

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

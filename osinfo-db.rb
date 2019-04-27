class OsinfoDb < Formula
  desc "Libosinfo database files"
  homepage "https://libosinfo.org/"
  url "https://releases.pagure.org/libosinfo/osinfo-db-20190319.tar.xz"
  sha256 "9c01c671f47c8927858e88406d6b6bd448f47dbb077917ac5acc4a80c188f5b5"

  depends_on "osinfo-db-tools" => :build

  def install
    system "osinfo-db-import", "--local", cached_download

    # Copy the archive into the prefix to avoid empty installation error
    cp_r "./", prefix
  end

  test do
    system "osinfo-db-validate", "--local"
  end
end

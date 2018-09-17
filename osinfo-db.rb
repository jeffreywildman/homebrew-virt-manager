class OsinfoDb < Formula
  desc "Libosinfo database files"
  homepage "https://libosinfo.org/"
  url "https://releases.pagure.org/libosinfo/osinfo-db-20180903.tar.xz"
  sha256 "c9d7f24be5a16238aa46f7168aacd87697acfae0b9b8905a266d8025acc77d76"

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

class OsinfoDb < Formula
  desc "Libosinfo database files"
  homepage "https://libosinfo.org/"
  url "https://releases.pagure.org/libosinfo/osinfo-db-20210202.tar.xz"
  sha256 "0bb56aeddf94a2cf48853c0e82cacaeb873d98c19590d81fbceadb06a391b11b"

  depends_on "osinfo-db-tools" => :build

  def install
    system "osinfo-db-import", "--local", cached_download

    # Avoid empty installation error
    (prefix/"keep").write("")
  end

  test do
    system "osinfo-db-validate", "--local"
  end
end

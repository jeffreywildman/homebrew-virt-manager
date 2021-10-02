class VirtManager < Formula
  include Language::Python::Virtualenv

  desc "App for managing virtual machines"
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-manager/virt-manager-3.2.0.tar.gz"
  sha256 "2b6fe3d90d89e1130227e4b05c51e6642d89c839d3ea063e0e29475fd9bf7b86"
  revision 7

  depends_on "docutils" => :build
  depends_on "gettext" => :build

  depends_on "adwaita-icon-theme"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "gtksourceview4"
  depends_on "libosinfo"
  depends_on "libvirt-glib"
  depends_on "libxml2"
  depends_on "osinfo-db"
  depends_on "python"
  depends_on "spice-gtk"
  depends_on "vte3"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6d/78/f8db8d57f520a54f0b8a438319c342c61c22759d8f9a1cd2e2180b5e5ea9/certifi-2021.5.30.tar.gz"
    sha256 "2bbf76fd432960138b3ef6dda3dde0544f27cbf8546c458e60baf371917ba9ee"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/eb/7f/a6c278746ddbd7094b019b08d1b2187101b1f596f35f81dc27f57d8fcf7c/charset-normalizer-2.0.6.tar.gz"
    sha256 "5ec46d183433dcbd0ab716f2d7f29d8dee50505b3fdb40c6b985c7c4f5a3591f"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/cb/38/4c4d00ddfa48abe616d7e572e02a04273603db446975ab46bbcd36552005/idna-3.2.tar.gz"
    sha256 "467fbad99067910785144ce333826c71fb0e63a425657295239737f7ecd125f3"
  end

  resource "libvirt-python" do
    url "https://files.pythonhosted.org/packages/20/fa/b8c7263b48dec918a5ce9c08ca457ef19836b87dd3f6ce91ff19e09c35fc/libvirt-python-7.8.0.tar.gz"
    sha256 "9d07416d66805bf1a17f34491b3ced2ac6c42b6a012ddf9177e0e3ae1b103fd5"
  end

  resource "pycairo" do
    url "https://files.pythonhosted.org/packages/bc/3f/64e6e066d163fbcf13213f9eeda0fc83376243335ea46a66cefd70d62e8f/pycairo-1.20.1.tar.gz"
    sha256 "1ee72b035b21a475e1ed648e26541b04e5d7e753d75ca79de8c583b25785531b"
  end

  resource "PyGObject" do
    url "https://files.pythonhosted.org/packages/cc/72/48cfdd7a0caf3c27f392d2657731ac6f7c3c1c0a60bfeba3e1ba9ffa7ba9/PyGObject-3.42.0.tar.gz"
    sha256 "b9803991ec0b0b4175e81fee0ad46090fa7af438fe169348a9b18ae53447afcd"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e7/01/3569e0b535fb2e4a6c384bdbed00c55b9d78b5084e0fb7f4d0bf523d7670/requests-2.26.0.tar.gz"
    sha256 "b8aa58f8cf793ffd8782d3d8cb19e66ef36f7aba4353eec859e74678b01b07a7"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/80/be/3ee43b6c5757cabea19e75b8f46eaf05a2f5144107d7db48c7cf3a864f73/urllib3-1.26.7.tar.gz"
    sha256 "4987c65554f7a2dbf30c18fd48778ef124af6fab771a377103da0585e2336ece"
  end

  # virt-manager doesn't prompt for password on macOS unless --no-fork flag is provided
  patch :DATA

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources

    # virt-manager uses distutils, doesn't like --single-version-externally-managed
    system libexec/"bin/python", "setup.py", "configure", "--prefix=#{libexec}"
    system libexec/"bin/python", "setup.py", "--no-user-cfg", "--no-update-icon-cache", "--no-compile-schemas", "install"

    # install virt-manager commands with PATH set to Python virtualenv environment
    bin.install Dir[libexec/"bin/virt-*"]
    bin.env_script_all_files(libexec/"bin", :PATH => "#{libexec}/bin:$PATH")

    share.install Dir[libexec/"share/man"]
    share.install Dir[libexec/"share/glib-2.0"]
    share.install Dir[libexec/"share/icons"]
  end

  def post_install
    # manual schema compile step
    system Formula["glib"].opt_bin/"glib-compile-schemas", HOMEBREW_PREFIX/"share/glib-2.0/schemas"
    # manual icon cache update step
    system Formula["gtk+3"].opt_bin/"gtk3-update-icon-cache", HOMEBREW_PREFIX/"share/icons/hicolor"
  end

  test do
    system bin/"virt-manager", "--version"
  end
end
__END__
diff --git a/virtManager/virtmanager.py b/virtManager/virtmanager.py
index f6d538b..1f01aa5 100755
--- a/virtManager/virtmanager.py
+++ b/virtManager/virtmanager.py
@@ -136,8 +136,8 @@ def parse_commandline():
     parser.add_argument("--debug", action="store_true",
         help="Print debug output to stdout (implies --no-fork)",
         default=False)
-    parser.add_argument("--no-fork", action="store_true",
-        help="Don't fork into background on startup")
+    parser.add_argument("--fork", dest='no_fork', action="store_false",
+        help="Fork into background on startup")

     parser.add_argument("--show-domain-creator", action="store_true",
         help="Show 'New VM' wizard")

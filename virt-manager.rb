class VirtManager < Formula
  include Language::Python::Virtualenv

  desc "App for managing virtual machines"
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-manager/virt-manager-3.2.0.tar.gz"
  sha256 "2b6fe3d90d89e1130227e4b05c51e6642d89c839d3ea063e0e29475fd9bf7b86"
  revision 8

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
    url "https://files.pythonhosted.org/packages/6c/ae/d26450834f0acc9e3d1f74508da6df1551ceab6c2ce0766a593362d6d57f/certifi-2021.10.8.tar.gz"
    sha256 "78884e7c1d4b00ce3cea67b44566851c4343c120abd683433ce934a68ea58872"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/48/44/76b179e0d1afe6e6a91fd5661c284f60238987f3b42b676d141d01cd5b97/charset-normalizer-2.0.10.tar.gz"
    sha256 "876d180e9d7432c5d1dfd4c5d26b72f099d503e8fcc0feb7532c9289be60fcbd"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/62/08/e3fc7c8161090f742f504f40b1bccbfc544d4a4e09eb774bf40aafce5436/idna-3.3.tar.gz"
    sha256 "9d643ff0a55b762d5cdb124b8eaa99c66322e2157b69160bc32796e824360e6d"
  end

  resource "libvirt-python" do
    url "https://files.pythonhosted.org/packages/9a/b5/0de1c04e45f082390d2adefde09fc851857a255a6e86ad7e9edf5e385bf7/libvirt-python-8.0.0.tar.gz"
    sha256 "0245c226d7b83b32449299d0ca5f1f250dcc07edf9f2fcd87cb7462f09e4c026"
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
    url "https://files.pythonhosted.org/packages/60/f3/26ff3767f099b73e0efa138a9998da67890793bfa475d8278f84a30fec77/requests-2.27.1.tar.gz"
    sha256 "68d7c56fd5a8999887728ef304a6d12edc7be74f1cfa47714fc8b414525c9a61"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/b0/b1/7bbf5181f8e3258efae31702f5eab87d8a74a72a0aa78bc8c08c1466e243/urllib3-1.26.8.tar.gz"
    sha256 "0e7c33d9a63e7ddfcb86780aac87befc2fbddf46c58dbb487e0855f7ceec283c"
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

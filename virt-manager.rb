class VirtManager < Formula
  include Language::Python::Virtualenv

  desc "App for managing virtual machines"
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-manager/virt-manager-3.2.0.tar.gz"
  sha256 "2b6fe3d90d89e1130227e4b05c51e6642d89c839d3ea063e0e29475fd9bf7b86"
  revision 3

  depends_on "docutils" => :build
  depends_on "gettext" => :build

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
    url "https://files.pythonhosted.org/packages/06/a9/cd1fd8ee13f73a4d4f491ee219deeeae20afefa914dfb4c130cfc9dc397a/certifi-2020.12.5.tar.gz"
    sha256 "1a4995114262bffbc2413b159f2a1a480c969de6e6eb13ee966d470af86af59c"
  end

  resource "chardet" do
    url "https://files.pythonhosted.org/packages/ee/2d/9cdc2b527e127b4c9db64b86647d567985940ac3698eeabc7ffaccb4ea61/chardet-4.0.0.tar.gz"
    sha256 "0d6f53a15db4120f2b08c94f11e7d93d2c911ee118b6b30a04ec3ee8310179fa"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ea/b7/e0e3c1c467636186c39925827be42f16fee389dc404ac29e930e9136be70/idna-2.10.tar.gz"
    sha256 "b307872f855b18632ce0c21c5e45be78c0ea7ae4c15c828c20788b26921eb3f6"
  end

  resource "libvirt-python" do
    url "https://files.pythonhosted.org/packages/55/1a/c3862f108a8591c18c54419fe5a0ee1a7ac8652029fa3c2ffc2352c5c9f8/libvirt-python-7.3.0.tar.gz"
    sha256 "676c260ddb365120404e611a38c514045ef1af1a7fede15c1fc02d0f8241f696"
  end

  resource "pycairo" do
    url "https://files.pythonhosted.org/packages/9d/6e/499d6a6db416eb3cdf0e57762a269908e4ab6638a75a90972afc34885b91/pycairo-1.20.0.tar.gz"
    sha256 "5695a10cb7f9ae0d01f665b56602a845b0a8cb17e2123bfece10c2e58552468c"
  end

  resource "PyGObject" do
    url "https://files.pythonhosted.org/packages/51/2f/4d5d5afb7000b9151e33952b59163c9389bd867ac6fe85d62f85831fa061/PyGObject-3.40.1.tar.gz"
    sha256 "6fb599aa59ceb9dd05fafb0d72b3862943e7d5e85c8ef6c74856bc6d4321cbab"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/6b/47/c14abc08432ab22dc18b9892252efaf005ab44066de871e72a38d6af464b/requests-2.25.1.tar.gz"
    sha256 "27973dd4a904a4f13b263a19c866c13b92a39ed1c964655f025f3f8d3d75b804"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/cb/cf/871177f1fc795c6c10787bc0e1f27bb6cf7b81dbde399fd35860472cecbc/urllib3-1.26.4.tar.gz"
    sha256 "e7b021f7241115872f92f43c6508082facffbd1c048e3c6e2bb9c2a157e28937"
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

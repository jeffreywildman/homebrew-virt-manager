class VirtManager < Formula
  include Language::Python::Virtualenv

  desc "App for managing virtual machines"
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-manager/virt-manager-1.5.1.tar.gz"
  sha256 "ee889d59110986391a394077f004f68125e01e216a5e7cfc29adb6ae49ab2dab"

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build

  depends_on "dbus"
  depends_on "adwaita-icon-theme"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "hicolor-icon-theme"
  depends_on "libosinfo"
  depends_on "libvirt"
  depends_on "libvirt-glib"
  depends_on "libxml2"
  depends_on "pygobject3" => "with-python@2"
  depends_on "spice-gtk"
  depends_on "vte3"
  depends_on "python@2" if MacOS.version <= :snow_leopard

  resource "libvirt-python" do
    url "https://libvirt.org/sources/python/libvirt-python-4.5.0.tar.gz"
    sha256 "ef35ed6bc24d76563b1ba9b068ef5a048016726dba62a9d057fe6dfbea6b0f60"
  end

  resource "idna" do
    url "https://pypi.io/packages/source/i/idna/idna-2.6.tar.gz"
    sha256 "2c6a5de3089009e3da7c5dde64a141dbc8551d5b7f6cf4ed7c2568d0cc520a8f"
  end

  resource "certifi" do
    url "https://pypi.io/packages/source/c/certifi/certifi-2017.7.27.1.tar.gz"
    sha256 "40523d2efb60523e113b44602298f0960e900388cf3bb6043f645cf57ea9e3f5"
  end

  resource "chardet" do
    url "https://pypi.io/packages/source/c/chardet/chardet-3.0.4.tar.gz"
    sha256 "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"
  end

  resource "urllib3" do
    url "https://pypi.io/packages/source/u/urllib3/urllib3-1.22.tar.gz"
    sha256 "cc44da8e1145637334317feebd728bd869a35285b93cbb4cca2577da7e62db4f"
  end

  resource "requests" do
    url "https://pypi.io/packages/source/r/requests/requests-2.18.4.tar.gz"
    sha256 "9c443e7324ba5b85070c4a818ade28bfabedf16ea10206da1132edaa6dda237e"
  end

  resource "ipaddr" do
    url "https://pypi.io/packages/source/i/ipaddr/ipaddr-2.2.0.tar.gz"
    sha256 "4092dfe667588d16aa12b59acb7c8a4024e5dcb23a681cd0b0b602373eca88d6"
  end

  # virt-manager does not launch on macOS unless --no-fork flag is provided
  patch :DATA

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install resources

    # recommended venv.pip_install_and_link buildpath does not work due to --single-version-externally-managed
    system "#{libexec}/bin/python", "setup.py",
                     "configure",
                     "--prefix=#{libexec}"
    system "#{libexec}/bin/python", "setup.py",
                     "--no-user-cfg",
                     "--no-update-icon-cache",
                     "--no-compile-schemas",
                     "install",
                     "--prefix=#{libexec}"

    # install virt-manager commands with PATH set to Python virtualenv environment
    bin.install Dir[libexec/"bin/virt-*"]
    bin.env_script_all_files(libexec/"bin", :PATH => "#{libexec}/bin:$PATH")

    # install and link schemas
    share.install Dir[libexec/"share/glib-2.0"]

    # install and link icons
    share.install Dir[libexec/"share/icons"]
  end

  def post_install
    # manual schema compile step
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
    # manual icon cache update step
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end

  test do
    system "#{bin}/virt-manager", "--version"
  end
end
__END__
--- a/virt-manager
+++ b/virt-manager
@@ -156,7 +156,8 @@
         help="Print debug output to stdout (implies --no-fork)",
         default=False)
     parser.add_argument("--no-fork", action="store_true",
-        help="Don't fork into background on startup")
+        help="Don't fork into background on startup",
+        default=True)
     parser.add_argument("--no-conn-autostart", action="store_true",
         dest="skip_autostart", help="Do not autostart connections")
     parser.add_argument("--spice-disable-auto-usbredir", action="store_true",

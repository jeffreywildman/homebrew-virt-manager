class VirtManager < Formula
  homepage "https://virt-manager.org/"
  url "https://virt-manager.org/download/sources/virt-manager/virt-manager-1.1.0.tar.gz"
  sha256 "ab0906cb15a132f1893f89ac4ca211c6c2c9c2d1860fbc285edbf9451c0f7941"

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build

  # TODO: don't rely on homebrewed python
  depends_on :python
  depends_on "pygobject3"
  depends_on "gtk+3"
  depends_on "libvirt-glib"
  depends_on "libxml2" => "with-python"
  depends_on "vte3"
  depends_on "d-bus"
  depends_on :x11
  depends_on "libosinfo"

  # TODO: audio
  depends_on "gtk-vnc"
  depends_on "spice-gtk"

  depends_on "libvirt"
  depends_on "hicolor-icon-theme"
  depends_on "gnome-icon-theme"

  resource "libvirt-python" do
    url "https://libvirt.org/sources/python/libvirt-python-1.2.15.tar.gz"
    sha256 "9a6dfbd487d49f887a41aca4bfb1b4e043fd9fbdfc041252cae84023f5c387ba"
  end

  # dependency of urlgrabber
  resource "pycurl" do
    url "https://pypi.python.org/packages/source/p/pycurl/pycurl-7.19.5.tar.gz"
    sha256 "69a0aa7c9dddbfe4cebf4d1f674c490faccf739fc930d85d8990ce2fd0551a43"
  end

  resource "urlgrabber" do
    url "https://pypi.python.org/packages/source/u/urlgrabber/urlgrabber-3.9.1.tar.gz"
    sha256 "b4e276fa968c66671309a6d754c4b3b0cb2003dec8bca87a681378a22e0d3da7"
  end

  resource "ipaddr" do
    url "https://pypi.python.org/packages/source/i/ipaddr/ipaddr-2.1.11.tar.gz"
    sha256 "1b555b8a8800134fdafe32b7d0cb52f5bdbfdd093707c3dd484c5ea59f1d98b7"
  end

  patch :DATA # fix shebangs

  def install
    ENV.prepend_create_path "PYTHONPATH", "#{libexec}/vendor/lib/python2.7/site-packages"
    %w[libvirt-python pycurl urlgrabber ipaddr].each do |r|
      resource(r).stage { system "python", *Language::Python.setup_install_args(libexec/"vendor") }
    end

    ENV.prepend_path "PYTHONPATH", "#{HOMEBREW_PREFIX}/opt/libxml2/lib/python2.7/site-packages"

    system "python", "setup.py",
                     "configure",
                     "--prefix=#{libexec}"
    system "python", "setup.py",
                     "install",
                     "--prefix=#{libexec}"

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])

    # install and link schemas
    share.install Dir[libexec/"share/glib-2.0"]

    # install and link icons
    share.install Dir[libexec/"share/icons"]
  end

  def post_install
    # manual schema compile step
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "#{HOMEBREW_PREFIX}/share/glib-2.0/schemas"
    # manual icon cache update step
    system "#{Formula["gtk+"].opt_bin}/gtk-update-icon-cache", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end
end
__END__
diff --git a/virt-clone b/virt-clone
index 4bd5ca3..6b4b9e5 100755
--- a/virt-clone
+++ b/virt-clone
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright(c) FUJITSU Limited 2007.
 #
diff --git a/virt-convert b/virt-convert
index a7f9a97..2f1ca7a 100755
--- a/virt-convert
+++ b/virt-convert
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright 2008, 2013, 2014  Red Hat, Inc.
 # Joey Boggs <jboggs@redhat.com>
diff --git a/virt-install b/virt-install
index 45607fb..4f9cf9e 100755
--- a/virt-install
+++ b/virt-install
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright 2005-2014 Red Hat, Inc.
 #
diff --git a/virt-manager b/virt-manager
index d352b90..5fccceb 100755
--- a/virt-manager
+++ b/virt-manager
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright (C) 2006, 2014 Red Hat, Inc.
 # Copyright (C) 2006 Daniel P. Berrange <berrange@redhat.com>
diff --git a/virt-xml b/virt-xml
index 4e0848c..eb40bfa 100755
--- a/virt-xml
+++ b/virt-xml
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python2 -tt
 #
 # Copyright 2013-2014 Red Hat, Inc.
 # Cole Robinson <crobinso@redhat.com>

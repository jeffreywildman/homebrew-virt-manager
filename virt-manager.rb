class VirtManager < Formula
  desc "App for managing virtual machines"
  homepage "https://virt-manager.org/"
  url "https://fedorahosted.org/released/virt-manager/virt-manager-1.3.2.tar.gz"
  sha256 "270c1f631fd029fee5291e83f50d69e261db666aa952c184643bc6cece77fdb3"

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build

  depends_on "d-bus"
  depends_on "gnome-icon-theme"
  depends_on "gtk+3"
  depends_on "gtk-vnc"
  depends_on "hicolor-icon-theme"
  depends_on "libosinfo"
  depends_on "libvirt"
  depends_on "libvirt-glib"
  depends_on "libxml2" => "with-python"
  depends_on "pygobject3"
  depends_on "spice-gtk"
  depends_on "vte3"
  depends_on :x11
  # TODO: audio

  resource "libvirt-python" do
    url "https://libvirt.org/sources/python/libvirt-python-1.3.3.tar.gz"
    sha256 "aa68ae788d44ae49ee43be69227f1db2e8c55a2b3499236b715dfbf6090c0e4a"
  end

  resource "requests" do
    url "https://pypi.python.org/packages/source/r/requests/requests-2.9.1.tar.gz"
    sha256 "c577815dd00f1394203fc44eb979724b098f88264a9ef898ee45b8e5e9cf587f"
  end

  resource "ipaddr" do
    url "https://pypi.python.org/packages/source/i/ipaddr/ipaddr-2.1.11.tar.gz"
    sha256 "1b555b8a8800134fdafe32b7d0cb52f5bdbfdd093707c3dd484c5ea59f1d98b7"
  end

  patch :DATA # fix shebangs

  def install
    # update location of cpu_map.xml
    # https://github.com/jeffreywildman/homebrew-virt-manager/issues/15
    inreplace "virtinst/capabilities.py", "/usr/share/libvirt/cpu_map.xml", "#{HOMEBREW_PREFIX}/share/libvirt/cpu_map.xml"

    ENV.prepend_create_path "PYTHONPATH", "#{libexec}/vendor/lib/python2.7/site-packages"
    %w[libvirt-python requests ipaddr].each do |r|
      resource(r).stage { system "python", *Language::Python.setup_install_args(libexec/"vendor") }
    end

    ENV.prepend_path "PYTHONPATH", "#{Formula["libxml2"].opt_lib}/python2.7/site-packages"

    system "python", "setup.py",
                     "configure",
                     "--prefix=#{libexec}"
    system "python", "setup.py",
                     "--no-user-cfg",
                     "--no-update-icon-cache",
                     "--no-compile-schemas",
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
    system "#{Formula["gtk+3"].opt_bin}/gtk3-update-icon-cache", "#{HOMEBREW_PREFIX}/share/icons/hicolor"
  end
end
__END__
diff --git a/virt-clone b/virt-clone
index 4bd5ca3..6b4b9e5 100755
--- a/virt-clone
+++ b/virt-clone
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python -tt
 #
 # Copyright(c) FUJITSU Limited 2007.
 #
diff --git a/virt-convert b/virt-convert
index a7f9a97..2f1ca7a 100755
--- a/virt-convert
+++ b/virt-convert
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python -tt
 #
 # Copyright 2008, 2013, 2014  Red Hat, Inc.
 # Joey Boggs <jboggs@redhat.com>
diff --git a/virt-install b/virt-install
index 45607fb..4f9cf9e 100755
--- a/virt-install
+++ b/virt-install
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python -tt
 #
 # Copyright 2005-2014 Red Hat, Inc.
 #
diff --git a/virt-manager b/virt-manager
index d352b90..5fccceb 100755
--- a/virt-manager
+++ b/virt-manager
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python -tt
 #
 # Copyright (C) 2006, 2014 Red Hat, Inc.
 # Copyright (C) 2006 Daniel P. Berrange <berrange@redhat.com>
diff --git a/virt-xml b/virt-xml
index 4e0848c..eb40bfa 100755
--- a/virt-xml
+++ b/virt-xml
@@ -1,4 +1,4 @@
-#!/usr/bin/python2 -tt
+#!/usr/bin/env python -tt
 #
 # Copyright 2013-2014 Red Hat, Inc.
 # Cole Robinson <crobinso@redhat.com>

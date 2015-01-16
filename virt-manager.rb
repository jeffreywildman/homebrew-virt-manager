class VirtManager < Formula
  homepage "http://virt-manager.org/"
  url "http://virt-manager.org/download/sources/virt-manager/virt-manager-1.1.0.tar.gz"
  sha1 "01b80584dad46fc79e57ecc3af4096332ab83fce"

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

  # Grab from https://pypi.python.org/ when available
  # See: http://forums.gentoo.org/viewtopic-p-7666282.html?sid=92edaf056c2ebfab536fc36f07e876b5
  resource "libvirt-python" do
    url "http://libvirt.org/sources/python/libvirt-python-1.2.10.tar.gz"
    sha1 "4ad64489f3d19eca72276b6d5314f50f04d1d12d"
  end

  # dependency of urlgrabber
  resource "pycurl" do
    url "https://pypi.python.org/packages/source/p/pycurl/pycurl-7.19.5.tar.gz"
    sha1 "ec36d55a99db9a49fede3bfa27ee16a4f5dc7bef"
  end

  resource "urlgrabber" do
    url "https://pypi.python.org/packages/source/u/urlgrabber/urlgrabber-3.9.1.tar.gz"
    sha1 "3d4e7d38f268a9b652f695a1d87e50aef1a3485c"
  end

  resource "ipaddr" do
    url "https://pypi.python.org/packages/source/i/ipaddr/ipaddr-2.1.11.tar.gz"
    sha1 "f9a16ddb3cf774b8dcf8894c2f4295c4e17d0ed3"
  end

  patch :DATA # fix shebangs, update location of gtk-update-icon-cache and glib-compile-schemas

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
diff --git a/virt-manager.spec b/virt-manager.spec
index 52c4969..caffea3 100644
--- a/virt-manager.spec
+++ b/virt-manager.spec
@@ -144,21 +144,21 @@ python setup.py install -O1 --root=$RPM_BUILD_ROOT
 
 %post
 /bin/touch --no-create %{_datadir}/icons/hicolor &>/dev/null || :
-/usr/bin/update-desktop-database &> /dev/null || :
+/usr/local/bin/update-desktop-database &> /dev/null || :
 
 
 %postun
 if [ $1 -eq 0 ] ; then
     /bin/touch --no-create %{_datadir}/icons/hicolor &>/dev/null
-    /usr/bin/gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
-    /usr/bin/glib-compile-schemas %{_datadir}/glib-2.0/schemas &> /dev/null || :
+    /usr/local/bin/gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
+    /usr/local/bin/glib-compile-schemas %{_datadir}/glib-2.0/schemas &> /dev/null || :
 fi
-/usr/bin/update-desktop-database &> /dev/null || :
+/usr/local/bin/update-desktop-database &> /dev/null || :
 
 
 %posttrans
-/usr/bin/gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
-/usr/bin/glib-compile-schemas %{_datadir}/glib-2.0/schemas &> /dev/null || :
+/usr/local/bin/gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
+/usr/local/bin/glib-compile-schemas %{_datadir}/glib-2.0/schemas &> /dev/null || :
 
 
 %files
diff --git a/virt-manager.spec.in b/virt-manager.spec.in
index e6991d8..577e5c3 100644
--- a/virt-manager.spec.in
+++ b/virt-manager.spec.in
@@ -144,21 +144,21 @@ python setup.py install -O1 --root=$RPM_BUILD_ROOT
 
 %post
 /bin/touch --no-create %{_datadir}/icons/hicolor &>/dev/null || :
-/usr/bin/update-desktop-database &> /dev/null || :
+/usr/local/bin/update-desktop-database &> /dev/null || :
 
 
 %postun
 if [ $1 -eq 0 ] ; then
     /bin/touch --no-create %{_datadir}/icons/hicolor &>/dev/null
-    /usr/bin/gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
-    /usr/bin/glib-compile-schemas %{_datadir}/glib-2.0/schemas &> /dev/null || :
+    /usr/local/bin/gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
+    /usr/local/bin/glib-compile-schemas %{_datadir}/glib-2.0/schemas &> /dev/null || :
 fi
-/usr/bin/update-desktop-database &> /dev/null || :
+/usr/local/bin/update-desktop-database &> /dev/null || :
 
 
 %posttrans
-/usr/bin/gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
-/usr/bin/glib-compile-schemas %{_datadir}/glib-2.0/schemas &> /dev/null || :
+/usr/local/bin/gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :
+/usr/local/bin/glib-compile-schemas %{_datadir}/glib-2.0/schemas &> /dev/null || :
 
 
 %files

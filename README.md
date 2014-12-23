homebrew-virt-manager
=====================

Updated/new formulae to build virt-manager on Mac OSX.

Included is a set of formulas covering a subset of virt-manager dependencies.
Also included is a work-in-progress formula for virt-manager.

# Usage

	brew tap jeffreywildman/homebrew-virt-manager
	brew install virt-manager

Note: SSH passwords for connecting to remote URIs are not prompted unless --debug or --no-fork is used to start virt-manager.

# Todo

* Get vnc console working: need formulas for dependencies gtk-vnc and spice-gtk3.
* Extend formula to support brewing virt-manager with system python.
* When available, update url for libvirt-python to pypi.python.org.
* Symlink installed files, e.g. schema files.

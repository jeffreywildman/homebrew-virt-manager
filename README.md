homebrew-virt-manager
=====================

Updated/new formulae to build `virt-manager` and `virt-viewer` on Mac OSX.

# Usage

    brew tap philelis/homebrew-virt-manager
    brew install virt-manager virt-viewer

# Notes

* For remote URIs, the `libvirt` socket location may need to be overridden to prevent socket hangups, see [www.jedi.be](http://www.jedi.be/blog/2011/09/13/libvirt-fog-provider/#macosx-remote-libvirt-client-).

        virt-manager -c qemu+ssh://user@libvirthost/system?socket=/var/run/libvirt/libvirt-sock
        virt-viewer -c qemu+ssh://user@libvirthost/system?socket=/var/run/libvirt/libvirt-sock

* SSH passwords for connecting to remote URIs are not prompted unless `--debug` or `--no-fork` is used to start `virt-manager`.


Debian
====================
This directory contains files used to package LeisureCoind/LeisureCoin-qt
for Debian-based Linux systems. If you compile LeisureCoind/LeisureCoin-qt yourself, there are some useful files here.

## LeisureCoin: URI support ##


LeisureCoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install LeisureCoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your LeisureCoinqt binary to `/usr/bin`
and the `../../share/pixmaps/LeisureCoin128.png` to `/usr/share/pixmaps`

LeisureCoin-qt.protocol (KDE)


#!/bin/bash

set -e

packages_file="/tmp/archlive/packages.x86_64"

# Packages to add to the archiso profile packages
packages=(
	gcc
	git
	pkgconfig
	python
	python-pip
	python-build
	python-setuptools
	python-wheel
	python-pyparted
	wget
	cowsay
	networkmanager
)

mkdir -p /tmp/archlive/

pacman --noconfirm -S archiso

cp -r /usr/share/archiso/configs/releng/* /tmp/archlive

sed -i /archinstall/d "$packages_file"

# Add packages to the archiso profile packages
for package in "${packages[@]}"; do
	echo "$package" >> "$packages_file"
done

find /tmp/archlive
cd /tmp/archlive

mkarchiso -v -w work/ -o out/ ./

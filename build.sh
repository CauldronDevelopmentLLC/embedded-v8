#!/bin/bash -e

cd "$(dirname "$0")"

# Prerequisites
sudo apt-get update
sudo apt-get -y install build-essential ninja-build python

# Build
python gn/build/gen.py
ninja -C gn/out
./gn/out/gn gen --args='is_debug=false use_custom_libcxx=false is_clang=false v8_enable_i18n_support=false v8_monolithic=true v8_use_external_startup_data=false disable_libfuzzer=true use_aura=false use_dbus=false use_ozone=false use_sysroot=false use_udev=false use_x11=false use_gio=false use_glib=false v8_has_valgrind=true' out
ninja -C out v8_monolith

# Rename files
mkdir -p lib
cp out/obj/libv8_monolith.a lib/libv8.a

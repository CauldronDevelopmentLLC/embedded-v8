Embedded V8 JavaScript Engine
=============
This is a stripped down version of Google's V8 JavaScript engine.
The purpose of this repo is to simplify the build process to make it
eaiser to embed v8 in other projects.  This repo will likely fall
behind the latest v8 releases.  See the real v8 repo for more info.
https://chromium.googlesource.com/v8/v8.git

## Created with

```
git clone https://chromium.googlesource.com/v8/v8.git --depth=1
cd v8
git clone https://gn.googlesource.com/gn
git -C gn checkout 2f5276089c50cc76bc9282ec1246304c4dafc5b8
git clone https://chromium.googlesource.com/chromium/src/build --depth=1
git clone https://chromium.googlesource.com/chromium/src/third_party/zlib.git third_party/zlib --depth=1
git clone https://chromium.googlesource.com/external/github.com/google/googletest.git third_party/googletest/src --depth=1
git clone https://chromium.googlesource.com/chromium/src/base/trace_event/common.git base/trace_event/common --depth=1
git clone https://chromium.googlesource.com/chromium/src/third_party/jinja2.git third_party/jinja2 --depth=1
git clone https://chromium.googlesource.com/chromium/src/third_party/markupsafe.git third_party/markupsafe --depth=1

echo -e "checkout_fuchsia_for_arm64_host = false\ncheckout_google_benchmark = false" >build/config/gclient_args.gni
sed -i 's/thread-count=4/thread-count=1/g' build/config/compiler/BUILD.gn
```

Also edited gn to not look for ``.git``.  A few other minor edits.

## Build
```
python gn/build/gen.py
ninja -C gn/out
./gn/out/gn gen --args='is_debug=false use_custom_libcxx=false is_clang=false v8_enable_i18n_support=false v8_monolithic=true v8_use_external_startup_data=false disable_libfuzzer=true use_aura=false use_dbus=false use_ozone=false use_sysroot=false use_udev=false use_x11=false use_gio=false use_glib=false v8_has_valgrind=true' out
ninja -C out v8_monolith
```

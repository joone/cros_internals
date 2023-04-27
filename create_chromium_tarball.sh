#!/bin/bash

#
# ./create_chromium_tarball.sh package ../chromium
#
set -eu

FILE=chromium.tar
FILE_TAR=chromium.tar

if [ "$1" == install ] || [ "$1" == update ];
then

if [ -z "$2" ]; then
  echo "Input a path for installation"
  exit 0
fi

  mkdir tmp_cr
  tar -xvf $FILE -C ./tmp_cr
  mv ./tmp_cr/chromium/src/out/Release $2
  rm -rf tmp_cr


elif [ "$1" == package ];
then


if [ -z "$2" ]; then
  echo "Input Chromium path"
else
  CHROMIUM_PATH=$2
  if [ -f "./$FILE" ]; then
    rm $FILE
  fi
#  strip $CHROMIUM_PATH/src/out/Release/headless_shell
#  strip $CHROMIUM_PATH/src/out/Release/*.so
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/headless_shell
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/content_shell
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/content_shell.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/chrome
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/chrome_crashpad_handler
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/locales
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/resources.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/chrome_100_percent.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/chrome_200_percent.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/shell_resources.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/ui_resources_100_percent.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/headless_lib_data.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/headless_lib_strings.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/headless_command_resources.pak
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/icudtl.dat
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/snapshot_blob.bin
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/libEGL.so
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/libGLESv2.so
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/libvk_swiftshader.so
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/libvulkan.so.1
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/vk_swiftshader_icd.json
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/libVkLayer_khronos_validation.so
  tar rvf $FILE_TAR $CHROMIUM_PATH/src/out/Release/v8_context_snapshot.bin
  tar tvf $FILE_TAR
  #gzip $FILE_TAR
fi

fi

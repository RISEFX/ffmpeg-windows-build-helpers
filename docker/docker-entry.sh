#!/bin/bash

# docker actually runs this as a script after having copied it in as part of the "big initial copy" making the image...

set -e

OUTPUTDIR=/output

# RISE: we set your fork and the branch with the customized code
./cross_compile_ffmpeg.sh --ffmpeg-git-checkout=https://github.com/RISEFX/FFmpeg.git --ffmpeg-git-checkout-version=n7.0.2-risefx --build-ffmpeg-shared=y --build-ffmpeg-static=y --disable-nonfree=n --build-intel-qsv=y --compiler-flavors=win64 --enable-gpl=y

mkdir -p $OUTPUTDIR/static/bin
# RISE: the output is in a different folder than what the script in the default is, change when changing the checkout version!
cp -R -f ./sandbox/win64/ffmpeg_git_with_fdk_aac_n7.0.2-risefx/ffmpeg.exe $OUTPUTDIR/static/bin
cp -R -f ./sandbox/win64/ffmpeg_git_with_fdk_aac_n7.0.2-risefx/ffprobe.exe $OUTPUTDIR/static/bin
cp -R -f ./sandbox/win64/ffmpeg_git_with_fdk_aac_n7.0.2-risefx/ffplay.exe $OUTPUTDIR/static/bin

mkdir -p $OUTPUTDIR/shared
cp -R -f ./sandbox/win64/ffmpeg_git_with_fdk_aac_n7.0.2-risefx_shared/bin/ $OUTPUTDIR/shared

if [[ -f /tmp/loop ]]; then
  echo 'sleeping forever so you can attach to this docker if desired' # without this if there's a build failure the docker exits and can't get in to tweak stuff??? :|
  sleep
fi

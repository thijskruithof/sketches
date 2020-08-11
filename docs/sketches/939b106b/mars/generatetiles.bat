@echo off
pushd %~dp0

rmdir /q /s Images
md Images
cd Images

rem lod 0
md 0
cd 0
FOR /L %%A IN (0,1,31) DO (
MD %%A
)
cd ..

rem lod 1
md 1
cd 1
FOR /L %%A IN (0,1,15) DO (
MD %%A
)
cd ..

rem lod 2
md 2
cd 2
FOR /L %%A IN (0,1,7) DO (
MD %%A
)
cd ..

rem lod 3
md 3
cd 3
FOR /L %%A IN (0,1,3) DO (
MD %%A
)
cd ..

rem lod 4
md 4
cd 4
FOR /L %%A IN (0,1,1) DO (
MD %%A
)
cd ..

rem lod 5
md 5
cd 5
MD 0
cd ..

cd ..

echo Generating tiles! This can take a while.

echo lod 0: 32x32 tiles @ 512
"C:\Program Files\ImageMagick-7.0.10-Q16-HDRI\magick" convert Combined_Huge.png -monitor -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 85 "Images\\0\\%%[filename:tile].webp"
echo lod 1: 16x16 tiles @ 512
"C:\Program Files\ImageMagick-7.0.10-Q16-HDRI\magick" convert Combined_Huge.png -monitor -resize "8192x8192" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 85 "Images\\1\\%%[filename:tile].webp"
echo lod 2: 8x8 tiles @ 512
"C:\Program Files\ImageMagick-7.0.10-Q16-HDRI\magick" convert Combined_Huge.png -monitor -resize "4096x4096" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 85 "Images\\2\\%%[filename:tile].webp"
echo lod 3: 4x4 tiles @ 512
"C:\Program Files\ImageMagick-7.0.10-Q16-HDRI\magick" convert Combined_Huge.png -monitor -resize "2048x2048" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 85 "Images\\3\\%%[filename:tile].webp"
echo lod 4: 2x2 tiles @ 512
"C:\Program Files\ImageMagick-7.0.10-Q16-HDRI\magick" convert Combined_Huge.png -monitor -resize "1024x1024" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 85 "Images\\4\\%%[filename:tile].webp"
echo lod 5: 1x1 tiles @ 512
"C:\Program Files\ImageMagick-7.0.10-Q16-HDRI\magick" convert Combined_Huge.png -monitor -resize "512x512" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 85 "Images\\5\\%%[filename:tile].webp"

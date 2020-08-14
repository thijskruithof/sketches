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

rem lod 6
md 6
cd 6
MD 0
cd ..

cd ..

rem echo Generating albedo tiles! This can take a while.

rem echo lod 0: 64x32 tiles @ 512
rem d:\Work\Map\ImageMagick\magick convert Combined_Huger.png -monitor -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 80 "Images\\0\\%%[filename:tile].jpg"
rem echo lod 1: 32x16 tiles @ 512
rem d:\Work\Map\ImageMagick\magick convert Combined_Huger.png -monitor -resize "16384x8192" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 80 "Images\\1\\%%[filename:tile].jpg"
rem echo lod 2: 16x8 tiles @ 512
rem d:\Work\Map\ImageMagick\magick convert Combined_Huger.png -monitor -resize "8192x4096" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 80 "Images\\2\\%%[filename:tile].jpg"
rem echo lod 3: 8x4 tiles @ 512
rem d:\Work\Map\ImageMagick\magick convert Combined_Huger.png -monitor -resize "4096x2048" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 80 "Images\\3\\%%[filename:tile].jpg"
rem echo lod 4: 4x2 tiles @ 512
rem d:\Work\Map\ImageMagick\magick convert Combined_Huger.png -monitor -resize "2048x1024" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 80 "Images\\4\\%%[filename:tile].jpg"
rem echo lod 5: 2x1 tiles @ 512
rem d:\Work\Map\ImageMagick\magick convert Combined_Huger.png -monitor -resize "1024x512" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -quality 80 "Images\\5\\%%[filename:tile].jpg"
rem echo lod 6: 1x1 tiles @ 512
rem d:\Work\Map\ImageMagick\magick convert Combined_Huger.png -monitor -resize "512x256" -crop 512x512 -set filename:tile "%%[fx:page.y/512]\\%%[fx:page.x/512]" +repage +adjoin -background black -extent 512x512 -quality 80 "Images\\6\\%%[filename:tile].jpg"

echo Generating elevation tiles! This can take a while.

echo lod 0: elevation 64x32 tiles @ 256
d:\Work\Map\ImageMagick\magick convert Elevation.png -monitor -resize "16384x8192" -crop 256x256 -set filename:tile "%%[fx:page.y/256]\\%%[fx:page.x/256]" +repage +adjoin -quality 70 "Images\\0\\%%[filename:tile]_e.jpg"
echo lod 1: elevation 32x16 tiles @ 256
d:\Work\Map\ImageMagick\magick convert Elevation.png -monitor -resize "8192x4096" -crop 256x256 -set filename:tile "%%[fx:page.y/256]\\%%[fx:page.x/256]" +repage +adjoin -quality 70 "Images\\1\\%%[filename:tile]_e.jpg"
echo lod 2: elevation 16x8 tiles @ 256
d:\Work\Map\ImageMagick\magick convert Elevation.png -monitor -resize "4096x2048" -crop 256x256 -set filename:tile "%%[fx:page.y/256]\\%%[fx:page.x/256]" +repage +adjoin -quality 70 "Images\\2\\%%[filename:tile]_e.jpg"
echo lod 3: elevation 8x4 tiles @ 256
d:\Work\Map\ImageMagick\magick convert Elevation.png -monitor -resize "2048x1024" -crop 256x256 -set filename:tile "%%[fx:page.y/256]\\%%[fx:page.x/256]" +repage +adjoin -quality 70 "Images\\3\\%%[filename:tile]_e.jpg"
echo lod 4: elevation 4x2 tiles @ 256
d:\Work\Map\ImageMagick\magick convert Elevation.png -monitor -resize "1024x512" -crop 256x256 -set filename:tile "%%[fx:page.y/256]\\%%[fx:page.x/256]" +repage +adjoin -quality 70 "Images\\4\\%%[filename:tile]_e.jpg"
echo lod 5: elevation 2x1 tiles @ 256
d:\Work\Map\ImageMagick\magick convert Elevation.png -monitor -resize "512x256" -crop 256x256 -set filename:tile "%%[fx:page.y/256]\\%%[fx:page.x/256]" +repage +adjoin -quality 70 "Images\\5\\%%[filename:tile]_e.jpg"
echo lod 6: elevation 1x1 tiles @ 256
d:\Work\Map\ImageMagick\magick convert Elevation.png -monitor -resize "256x128" -crop 256x256 -set filename:tile "%%[fx:page.y/256]\\%%[fx:page.x/256]" +repage +adjoin -background black -extent 256x256 -quality 70 "Images\\6\\%%[filename:tile]_e.jpg"

@echo off

REM Hacked together on https://playcode.io/


rem function toBin(num, size=4) { if (size < 1) size = 1; var s = "000000000000000000" + num.toString(2); return s.substr(s.length-size); }
rem function toHex(num, size=2) { if (size < 1) size = 1; var s = "000000000000000000" + num.toString(16); return s.substr(s.length-size); }
rem for (var lod=0; lod<4; ++lod)
rem for (var y=0; y<16; ++y)
rem for (var x=0; x<16; ++x)
rem {  
rem   var bg = "#" + toHex((x%2)*255) + toHex(y*16) + toHex(x*16);
rem   var txt = (x >= 8 || y >= 8 || lod >= 8) ? "#000000" : "#ffffff";
rem   var caption = lod.toString() + "\\n" + toBin(y) + "\\n" + toBin(x);
rem   var fn = lod.toString() + "_" + toBin(y) + "_" + toBin(x) + ".jpg";
rem   var s = "magick.exe -size 256x256 -background \"" + 
rem     bg + 
rem     "\" -fill \"" +
rem     txt + 
rem     "\" -gravity center -pointsize 60 caption:\"" + 
rem     caption + "\" -flatten -stroke \"" + 
rem     txt + "\" -strokeWidth 4 -fill \"#00000000\" -draw \"rectangle 0,0,255,255\" " +
rem     fn;
rem   console.log(s);
rem }
rem // Generate lower lods
rem for (var lod = 1; lod<=4; lod++)
rem {
rem   lodDim = (256 >> lod);
rem   numSourceTiles = 1 << lod;
rem   for (var y=0; y<16;y+=numSourceTiles)
rem   for (var x=0; x<16;x+=numSourceTiles)
rem   {  
rem     var fns = "";
rem     for (var iy=y; iy<y+numSourceTiles; iy++)
rem     for (var ix=x; ix<x+numSourceTiles; ix++)
rem     {
rem       var fn =  lod.toString()+"_" + toBin(iy) + "_" + toBin(ix) + ".jpg";  
rem       fns += fn + " ";
rem     }
rem     var dest_fn = lod.toString();
rem     if (lod < 4)    
rem      dest_fn += "_" + toBin(y/numSourceTiles,4-lod) + "_" + toBin(x/numSourceTiles,4-lod);
rem     dest_fn += ".jpg";
rem     var s = "magick.exe montage " + fns + " -geometry " + lodDim.toString() + "x" + lodDim.toString() + " " +
rem       dest_fn;
rem     console.log(s);
rem   }
rem }
rem for (var lod=1; lod<4; ++lod)
rem for (var y=0; y<16; ++y)
rem for (var x=0; x<16; ++x)
rem {  
rem   var fn = lod.toString() + "_" + toBin(y) + "_" + toBin(x) + ".jpg";
rem   var s = "delete " + fn;
rem   console.log(s);
rem }


magick.exe -size 256x256 -background "#000000" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0000\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_0000.jpg
magick.exe -size 256x256 -background "#ff0010" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0000\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_0001.jpg
magick.exe -size 256x256 -background "#000020" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0000\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_0010.jpg
magick.exe -size 256x256 -background "#ff0030" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0000\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_0011.jpg
magick.exe -size 256x256 -background "#000040" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0000\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_0100.jpg
magick.exe -size 256x256 -background "#ff0050" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0000\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_0101.jpg
magick.exe -size 256x256 -background "#000060" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0000\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_0110.jpg
magick.exe -size 256x256 -background "#ff0070" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0000\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_0111.jpg
magick.exe -size 256x256 -background "#000080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0000\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_1000.jpg
magick.exe -size 256x256 -background "#ff0090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0000\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_1001.jpg
magick.exe -size 256x256 -background "#0000a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0000\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_1010.jpg
magick.exe -size 256x256 -background "#ff00b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0000\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_1011.jpg
magick.exe -size 256x256 -background "#0000c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0000\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_1100.jpg
magick.exe -size 256x256 -background "#ff00d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0000\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_1101.jpg
magick.exe -size 256x256 -background "#0000e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0000\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_1110.jpg
magick.exe -size 256x256 -background "#ff00f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0000\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0000_1111.jpg
magick.exe -size 256x256 -background "#001000" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0001\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_0000.jpg
magick.exe -size 256x256 -background "#ff1010" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0001\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_0001.jpg
magick.exe -size 256x256 -background "#001020" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0001\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_0010.jpg
magick.exe -size 256x256 -background "#ff1030" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0001\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_0011.jpg
magick.exe -size 256x256 -background "#001040" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0001\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_0100.jpg
magick.exe -size 256x256 -background "#ff1050" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0001\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_0101.jpg
magick.exe -size 256x256 -background "#001060" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0001\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_0110.jpg
magick.exe -size 256x256 -background "#ff1070" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0001\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_0111.jpg
magick.exe -size 256x256 -background "#001080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0001\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_1000.jpg
magick.exe -size 256x256 -background "#ff1090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0001\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_1001.jpg
magick.exe -size 256x256 -background "#0010a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0001\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_1010.jpg
magick.exe -size 256x256 -background "#ff10b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0001\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_1011.jpg
magick.exe -size 256x256 -background "#0010c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0001\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_1100.jpg
magick.exe -size 256x256 -background "#ff10d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0001\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_1101.jpg
magick.exe -size 256x256 -background "#0010e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0001\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_1110.jpg
magick.exe -size 256x256 -background "#ff10f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0001\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0001_1111.jpg
magick.exe -size 256x256 -background "#002000" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0010\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_0000.jpg
magick.exe -size 256x256 -background "#ff2010" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0010\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_0001.jpg
magick.exe -size 256x256 -background "#002020" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0010\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_0010.jpg
magick.exe -size 256x256 -background "#ff2030" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0010\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_0011.jpg
magick.exe -size 256x256 -background "#002040" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0010\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_0100.jpg
magick.exe -size 256x256 -background "#ff2050" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0010\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_0101.jpg
magick.exe -size 256x256 -background "#002060" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0010\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_0110.jpg
magick.exe -size 256x256 -background "#ff2070" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0010\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_0111.jpg
magick.exe -size 256x256 -background "#002080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0010\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_1000.jpg
magick.exe -size 256x256 -background "#ff2090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0010\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_1001.jpg
magick.exe -size 256x256 -background "#0020a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0010\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_1010.jpg
magick.exe -size 256x256 -background "#ff20b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0010\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_1011.jpg
magick.exe -size 256x256 -background "#0020c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0010\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_1100.jpg
magick.exe -size 256x256 -background "#ff20d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0010\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_1101.jpg
magick.exe -size 256x256 -background "#0020e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0010\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_1110.jpg
magick.exe -size 256x256 -background "#ff20f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0010\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0010_1111.jpg
magick.exe -size 256x256 -background "#003000" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0011\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_0000.jpg
magick.exe -size 256x256 -background "#ff3010" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0011\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_0001.jpg
magick.exe -size 256x256 -background "#003020" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0011\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_0010.jpg
magick.exe -size 256x256 -background "#ff3030" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0011\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_0011.jpg
magick.exe -size 256x256 -background "#003040" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0011\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_0100.jpg
magick.exe -size 256x256 -background "#ff3050" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0011\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_0101.jpg
magick.exe -size 256x256 -background "#003060" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0011\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_0110.jpg
magick.exe -size 256x256 -background "#ff3070" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0011\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_0111.jpg
magick.exe -size 256x256 -background "#003080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0011\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_1000.jpg
magick.exe -size 256x256 -background "#ff3090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0011\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_1001.jpg
magick.exe -size 256x256 -background "#0030a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0011\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_1010.jpg
magick.exe -size 256x256 -background "#ff30b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0011\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_1011.jpg
magick.exe -size 256x256 -background "#0030c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0011\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_1100.jpg
magick.exe -size 256x256 -background "#ff30d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0011\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_1101.jpg
magick.exe -size 256x256 -background "#0030e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0011\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_1110.jpg
magick.exe -size 256x256 -background "#ff30f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0011\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0011_1111.jpg
magick.exe -size 256x256 -background "#004000" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0100\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_0000.jpg
magick.exe -size 256x256 -background "#ff4010" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0100\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_0001.jpg
magick.exe -size 256x256 -background "#004020" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0100\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_0010.jpg
magick.exe -size 256x256 -background "#ff4030" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0100\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_0011.jpg
magick.exe -size 256x256 -background "#004040" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0100\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_0100.jpg
magick.exe -size 256x256 -background "#ff4050" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0100\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_0101.jpg
magick.exe -size 256x256 -background "#004060" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0100\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_0110.jpg
magick.exe -size 256x256 -background "#ff4070" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0100\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_0111.jpg
magick.exe -size 256x256 -background "#004080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0100\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_1000.jpg
magick.exe -size 256x256 -background "#ff4090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0100\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_1001.jpg
magick.exe -size 256x256 -background "#0040a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0100\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_1010.jpg
magick.exe -size 256x256 -background "#ff40b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0100\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_1011.jpg
magick.exe -size 256x256 -background "#0040c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0100\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_1100.jpg
magick.exe -size 256x256 -background "#ff40d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0100\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_1101.jpg
magick.exe -size 256x256 -background "#0040e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0100\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_1110.jpg
magick.exe -size 256x256 -background "#ff40f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0100\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0100_1111.jpg
magick.exe -size 256x256 -background "#005000" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0101\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_0000.jpg
magick.exe -size 256x256 -background "#ff5010" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0101\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_0001.jpg
magick.exe -size 256x256 -background "#005020" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0101\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_0010.jpg
magick.exe -size 256x256 -background "#ff5030" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0101\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_0011.jpg
magick.exe -size 256x256 -background "#005040" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0101\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_0100.jpg
magick.exe -size 256x256 -background "#ff5050" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0101\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_0101.jpg
magick.exe -size 256x256 -background "#005060" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0101\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_0110.jpg
magick.exe -size 256x256 -background "#ff5070" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0101\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_0111.jpg
magick.exe -size 256x256 -background "#005080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0101\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_1000.jpg
magick.exe -size 256x256 -background "#ff5090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0101\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_1001.jpg
magick.exe -size 256x256 -background "#0050a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0101\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_1010.jpg
magick.exe -size 256x256 -background "#ff50b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0101\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_1011.jpg
magick.exe -size 256x256 -background "#0050c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0101\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_1100.jpg
magick.exe -size 256x256 -background "#ff50d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0101\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_1101.jpg
magick.exe -size 256x256 -background "#0050e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0101\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_1110.jpg
magick.exe -size 256x256 -background "#ff50f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0101\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0101_1111.jpg
magick.exe -size 256x256 -background "#006000" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0110\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_0000.jpg
magick.exe -size 256x256 -background "#ff6010" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0110\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_0001.jpg
magick.exe -size 256x256 -background "#006020" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0110\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_0010.jpg
magick.exe -size 256x256 -background "#ff6030" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0110\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_0011.jpg
magick.exe -size 256x256 -background "#006040" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0110\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_0100.jpg
magick.exe -size 256x256 -background "#ff6050" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0110\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_0101.jpg
magick.exe -size 256x256 -background "#006060" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0110\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_0110.jpg
magick.exe -size 256x256 -background "#ff6070" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0110\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_0111.jpg
magick.exe -size 256x256 -background "#006080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0110\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_1000.jpg
magick.exe -size 256x256 -background "#ff6090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0110\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_1001.jpg
magick.exe -size 256x256 -background "#0060a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0110\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_1010.jpg
magick.exe -size 256x256 -background "#ff60b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0110\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_1011.jpg
magick.exe -size 256x256 -background "#0060c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0110\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_1100.jpg
magick.exe -size 256x256 -background "#ff60d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0110\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_1101.jpg
magick.exe -size 256x256 -background "#0060e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0110\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_1110.jpg
magick.exe -size 256x256 -background "#ff60f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0110\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0110_1111.jpg
magick.exe -size 256x256 -background "#007000" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0111\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_0000.jpg
magick.exe -size 256x256 -background "#ff7010" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0111\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_0001.jpg
magick.exe -size 256x256 -background "#007020" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0111\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_0010.jpg
magick.exe -size 256x256 -background "#ff7030" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0111\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_0011.jpg
magick.exe -size 256x256 -background "#007040" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0111\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_0100.jpg
magick.exe -size 256x256 -background "#ff7050" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0111\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_0101.jpg
magick.exe -size 256x256 -background "#007060" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0111\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_0110.jpg
magick.exe -size 256x256 -background "#ff7070" -fill "#ffffff" -gravity center -pointsize 60 caption:"0\n0111\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_0111.jpg
magick.exe -size 256x256 -background "#007080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0111\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_1000.jpg
magick.exe -size 256x256 -background "#ff7090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0111\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_1001.jpg
magick.exe -size 256x256 -background "#0070a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0111\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_1010.jpg
magick.exe -size 256x256 -background "#ff70b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0111\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_1011.jpg
magick.exe -size 256x256 -background "#0070c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0111\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_1100.jpg
magick.exe -size 256x256 -background "#ff70d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0111\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_1101.jpg
magick.exe -size 256x256 -background "#0070e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0111\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_1110.jpg
magick.exe -size 256x256 -background "#ff70f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n0111\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_0111_1111.jpg
magick.exe -size 256x256 -background "#008000" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_0000.jpg
magick.exe -size 256x256 -background "#ff8010" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_0001.jpg
magick.exe -size 256x256 -background "#008020" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_0010.jpg
magick.exe -size 256x256 -background "#ff8030" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_0011.jpg
magick.exe -size 256x256 -background "#008040" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_0100.jpg
magick.exe -size 256x256 -background "#ff8050" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_0101.jpg
magick.exe -size 256x256 -background "#008060" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_0110.jpg
magick.exe -size 256x256 -background "#ff8070" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_0111.jpg
magick.exe -size 256x256 -background "#008080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_1000.jpg
magick.exe -size 256x256 -background "#ff8090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_1001.jpg
magick.exe -size 256x256 -background "#0080a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_1010.jpg
magick.exe -size 256x256 -background "#ff80b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_1011.jpg
magick.exe -size 256x256 -background "#0080c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_1100.jpg
magick.exe -size 256x256 -background "#ff80d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_1101.jpg
magick.exe -size 256x256 -background "#0080e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_1110.jpg
magick.exe -size 256x256 -background "#ff80f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1000\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1000_1111.jpg
magick.exe -size 256x256 -background "#009000" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_0000.jpg
magick.exe -size 256x256 -background "#ff9010" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_0001.jpg
magick.exe -size 256x256 -background "#009020" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_0010.jpg
magick.exe -size 256x256 -background "#ff9030" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_0011.jpg
magick.exe -size 256x256 -background "#009040" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_0100.jpg
magick.exe -size 256x256 -background "#ff9050" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_0101.jpg
magick.exe -size 256x256 -background "#009060" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_0110.jpg
magick.exe -size 256x256 -background "#ff9070" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_0111.jpg
magick.exe -size 256x256 -background "#009080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_1000.jpg
magick.exe -size 256x256 -background "#ff9090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_1001.jpg
magick.exe -size 256x256 -background "#0090a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_1010.jpg
magick.exe -size 256x256 -background "#ff90b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_1011.jpg
magick.exe -size 256x256 -background "#0090c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_1100.jpg
magick.exe -size 256x256 -background "#ff90d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_1101.jpg
magick.exe -size 256x256 -background "#0090e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_1110.jpg
magick.exe -size 256x256 -background "#ff90f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1001\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1001_1111.jpg
magick.exe -size 256x256 -background "#00a000" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_0000.jpg
magick.exe -size 256x256 -background "#ffa010" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_0001.jpg
magick.exe -size 256x256 -background "#00a020" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_0010.jpg
magick.exe -size 256x256 -background "#ffa030" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_0011.jpg
magick.exe -size 256x256 -background "#00a040" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_0100.jpg
magick.exe -size 256x256 -background "#ffa050" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_0101.jpg
magick.exe -size 256x256 -background "#00a060" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_0110.jpg
magick.exe -size 256x256 -background "#ffa070" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_0111.jpg
magick.exe -size 256x256 -background "#00a080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_1000.jpg
magick.exe -size 256x256 -background "#ffa090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_1001.jpg
magick.exe -size 256x256 -background "#00a0a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_1010.jpg
magick.exe -size 256x256 -background "#ffa0b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_1011.jpg
magick.exe -size 256x256 -background "#00a0c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_1100.jpg
magick.exe -size 256x256 -background "#ffa0d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_1101.jpg
magick.exe -size 256x256 -background "#00a0e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_1110.jpg
magick.exe -size 256x256 -background "#ffa0f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1010\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1010_1111.jpg
magick.exe -size 256x256 -background "#00b000" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_0000.jpg
magick.exe -size 256x256 -background "#ffb010" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_0001.jpg
magick.exe -size 256x256 -background "#00b020" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_0010.jpg
magick.exe -size 256x256 -background "#ffb030" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_0011.jpg
magick.exe -size 256x256 -background "#00b040" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_0100.jpg
magick.exe -size 256x256 -background "#ffb050" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_0101.jpg
magick.exe -size 256x256 -background "#00b060" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_0110.jpg
magick.exe -size 256x256 -background "#ffb070" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_0111.jpg
magick.exe -size 256x256 -background "#00b080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_1000.jpg
magick.exe -size 256x256 -background "#ffb090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_1001.jpg
magick.exe -size 256x256 -background "#00b0a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_1010.jpg
magick.exe -size 256x256 -background "#ffb0b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_1011.jpg
magick.exe -size 256x256 -background "#00b0c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_1100.jpg
magick.exe -size 256x256 -background "#ffb0d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_1101.jpg
magick.exe -size 256x256 -background "#00b0e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_1110.jpg
magick.exe -size 256x256 -background "#ffb0f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1011\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1011_1111.jpg
magick.exe -size 256x256 -background "#00c000" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_0000.jpg
magick.exe -size 256x256 -background "#ffc010" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_0001.jpg
magick.exe -size 256x256 -background "#00c020" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_0010.jpg
magick.exe -size 256x256 -background "#ffc030" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_0011.jpg
magick.exe -size 256x256 -background "#00c040" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_0100.jpg
magick.exe -size 256x256 -background "#ffc050" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_0101.jpg
magick.exe -size 256x256 -background "#00c060" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_0110.jpg
magick.exe -size 256x256 -background "#ffc070" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_0111.jpg
magick.exe -size 256x256 -background "#00c080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_1000.jpg
magick.exe -size 256x256 -background "#ffc090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_1001.jpg
magick.exe -size 256x256 -background "#00c0a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_1010.jpg
magick.exe -size 256x256 -background "#ffc0b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_1011.jpg
magick.exe -size 256x256 -background "#00c0c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_1100.jpg
magick.exe -size 256x256 -background "#ffc0d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_1101.jpg
magick.exe -size 256x256 -background "#00c0e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_1110.jpg
magick.exe -size 256x256 -background "#ffc0f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1100\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1100_1111.jpg
magick.exe -size 256x256 -background "#00d000" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_0000.jpg
magick.exe -size 256x256 -background "#ffd010" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_0001.jpg
magick.exe -size 256x256 -background "#00d020" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_0010.jpg
magick.exe -size 256x256 -background "#ffd030" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_0011.jpg
magick.exe -size 256x256 -background "#00d040" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_0100.jpg
magick.exe -size 256x256 -background "#ffd050" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_0101.jpg
magick.exe -size 256x256 -background "#00d060" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_0110.jpg
magick.exe -size 256x256 -background "#ffd070" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_0111.jpg
magick.exe -size 256x256 -background "#00d080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_1000.jpg
magick.exe -size 256x256 -background "#ffd090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_1001.jpg
magick.exe -size 256x256 -background "#00d0a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_1010.jpg
magick.exe -size 256x256 -background "#ffd0b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_1011.jpg
magick.exe -size 256x256 -background "#00d0c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_1100.jpg
magick.exe -size 256x256 -background "#ffd0d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_1101.jpg
magick.exe -size 256x256 -background "#00d0e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_1110.jpg
magick.exe -size 256x256 -background "#ffd0f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1101\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1101_1111.jpg
magick.exe -size 256x256 -background "#00e000" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_0000.jpg
magick.exe -size 256x256 -background "#ffe010" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_0001.jpg
magick.exe -size 256x256 -background "#00e020" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_0010.jpg
magick.exe -size 256x256 -background "#ffe030" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_0011.jpg
magick.exe -size 256x256 -background "#00e040" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_0100.jpg
magick.exe -size 256x256 -background "#ffe050" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_0101.jpg
magick.exe -size 256x256 -background "#00e060" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_0110.jpg
magick.exe -size 256x256 -background "#ffe070" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_0111.jpg
magick.exe -size 256x256 -background "#00e080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_1000.jpg
magick.exe -size 256x256 -background "#ffe090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_1001.jpg
magick.exe -size 256x256 -background "#00e0a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_1010.jpg
magick.exe -size 256x256 -background "#ffe0b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_1011.jpg
magick.exe -size 256x256 -background "#00e0c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_1100.jpg
magick.exe -size 256x256 -background "#ffe0d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_1101.jpg
magick.exe -size 256x256 -background "#00e0e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_1110.jpg
magick.exe -size 256x256 -background "#ffe0f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1110\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1110_1111.jpg
magick.exe -size 256x256 -background "#00f000" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_0000.jpg
magick.exe -size 256x256 -background "#fff010" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_0001.jpg
magick.exe -size 256x256 -background "#00f020" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_0010.jpg
magick.exe -size 256x256 -background "#fff030" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_0011.jpg
magick.exe -size 256x256 -background "#00f040" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_0100.jpg
magick.exe -size 256x256 -background "#fff050" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_0101.jpg
magick.exe -size 256x256 -background "#00f060" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_0110.jpg
magick.exe -size 256x256 -background "#fff070" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_0111.jpg
magick.exe -size 256x256 -background "#00f080" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_1000.jpg
magick.exe -size 256x256 -background "#fff090" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_1001.jpg
magick.exe -size 256x256 -background "#00f0a0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_1010.jpg
magick.exe -size 256x256 -background "#fff0b0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_1011.jpg
magick.exe -size 256x256 -background "#00f0c0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_1100.jpg
magick.exe -size 256x256 -background "#fff0d0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_1101.jpg
magick.exe -size 256x256 -background "#00f0e0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_1110.jpg
magick.exe -size 256x256 -background "#fff0f0" -fill "#000000" -gravity center -pointsize 60 caption:"0\n1111\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 0_1111_1111.jpg
magick.exe -size 256x256 -background "#000000" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0000\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_0000.jpg
magick.exe -size 256x256 -background "#ff0010" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0000\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_0001.jpg
magick.exe -size 256x256 -background "#000020" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0000\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_0010.jpg
magick.exe -size 256x256 -background "#ff0030" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0000\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_0011.jpg
magick.exe -size 256x256 -background "#000040" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0000\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_0100.jpg
magick.exe -size 256x256 -background "#ff0050" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0000\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_0101.jpg
magick.exe -size 256x256 -background "#000060" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0000\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_0110.jpg
magick.exe -size 256x256 -background "#ff0070" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0000\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_0111.jpg
magick.exe -size 256x256 -background "#000080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0000\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_1000.jpg
magick.exe -size 256x256 -background "#ff0090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0000\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_1001.jpg
magick.exe -size 256x256 -background "#0000a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0000\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_1010.jpg
magick.exe -size 256x256 -background "#ff00b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0000\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_1011.jpg
magick.exe -size 256x256 -background "#0000c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0000\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_1100.jpg
magick.exe -size 256x256 -background "#ff00d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0000\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_1101.jpg
magick.exe -size 256x256 -background "#0000e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0000\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_1110.jpg
magick.exe -size 256x256 -background "#ff00f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0000\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0000_1111.jpg
magick.exe -size 256x256 -background "#001000" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0001\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_0000.jpg
magick.exe -size 256x256 -background "#ff1010" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0001\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_0001.jpg
magick.exe -size 256x256 -background "#001020" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0001\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_0010.jpg
magick.exe -size 256x256 -background "#ff1030" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0001\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_0011.jpg
magick.exe -size 256x256 -background "#001040" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0001\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_0100.jpg
magick.exe -size 256x256 -background "#ff1050" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0001\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_0101.jpg
magick.exe -size 256x256 -background "#001060" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0001\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_0110.jpg
magick.exe -size 256x256 -background "#ff1070" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0001\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_0111.jpg
magick.exe -size 256x256 -background "#001080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0001\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_1000.jpg
magick.exe -size 256x256 -background "#ff1090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0001\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_1001.jpg
magick.exe -size 256x256 -background "#0010a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0001\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_1010.jpg
magick.exe -size 256x256 -background "#ff10b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0001\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_1011.jpg
magick.exe -size 256x256 -background "#0010c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0001\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_1100.jpg
magick.exe -size 256x256 -background "#ff10d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0001\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_1101.jpg
magick.exe -size 256x256 -background "#0010e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0001\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_1110.jpg
magick.exe -size 256x256 -background "#ff10f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0001\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0001_1111.jpg
magick.exe -size 256x256 -background "#002000" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0010\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_0000.jpg
magick.exe -size 256x256 -background "#ff2010" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0010\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_0001.jpg
magick.exe -size 256x256 -background "#002020" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0010\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_0010.jpg
magick.exe -size 256x256 -background "#ff2030" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0010\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_0011.jpg
magick.exe -size 256x256 -background "#002040" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0010\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_0100.jpg
magick.exe -size 256x256 -background "#ff2050" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0010\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_0101.jpg
magick.exe -size 256x256 -background "#002060" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0010\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_0110.jpg
magick.exe -size 256x256 -background "#ff2070" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0010\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_0111.jpg
magick.exe -size 256x256 -background "#002080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0010\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_1000.jpg
magick.exe -size 256x256 -background "#ff2090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0010\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_1001.jpg
magick.exe -size 256x256 -background "#0020a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0010\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_1010.jpg
magick.exe -size 256x256 -background "#ff20b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0010\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_1011.jpg
magick.exe -size 256x256 -background "#0020c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0010\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_1100.jpg
magick.exe -size 256x256 -background "#ff20d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0010\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_1101.jpg
magick.exe -size 256x256 -background "#0020e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0010\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_1110.jpg
magick.exe -size 256x256 -background "#ff20f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0010\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0010_1111.jpg
magick.exe -size 256x256 -background "#003000" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0011\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_0000.jpg
magick.exe -size 256x256 -background "#ff3010" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0011\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_0001.jpg
magick.exe -size 256x256 -background "#003020" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0011\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_0010.jpg
magick.exe -size 256x256 -background "#ff3030" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0011\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_0011.jpg
magick.exe -size 256x256 -background "#003040" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0011\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_0100.jpg
magick.exe -size 256x256 -background "#ff3050" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0011\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_0101.jpg
magick.exe -size 256x256 -background "#003060" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0011\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_0110.jpg
magick.exe -size 256x256 -background "#ff3070" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0011\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_0111.jpg
magick.exe -size 256x256 -background "#003080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0011\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_1000.jpg
magick.exe -size 256x256 -background "#ff3090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0011\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_1001.jpg
magick.exe -size 256x256 -background "#0030a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0011\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_1010.jpg
magick.exe -size 256x256 -background "#ff30b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0011\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_1011.jpg
magick.exe -size 256x256 -background "#0030c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0011\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_1100.jpg
magick.exe -size 256x256 -background "#ff30d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0011\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_1101.jpg
magick.exe -size 256x256 -background "#0030e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0011\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_1110.jpg
magick.exe -size 256x256 -background "#ff30f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0011\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0011_1111.jpg
magick.exe -size 256x256 -background "#004000" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0100\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_0000.jpg
magick.exe -size 256x256 -background "#ff4010" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0100\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_0001.jpg
magick.exe -size 256x256 -background "#004020" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0100\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_0010.jpg
magick.exe -size 256x256 -background "#ff4030" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0100\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_0011.jpg
magick.exe -size 256x256 -background "#004040" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0100\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_0100.jpg
magick.exe -size 256x256 -background "#ff4050" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0100\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_0101.jpg
magick.exe -size 256x256 -background "#004060" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0100\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_0110.jpg
magick.exe -size 256x256 -background "#ff4070" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0100\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_0111.jpg
magick.exe -size 256x256 -background "#004080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0100\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_1000.jpg
magick.exe -size 256x256 -background "#ff4090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0100\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_1001.jpg
magick.exe -size 256x256 -background "#0040a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0100\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_1010.jpg
magick.exe -size 256x256 -background "#ff40b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0100\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_1011.jpg
magick.exe -size 256x256 -background "#0040c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0100\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_1100.jpg
magick.exe -size 256x256 -background "#ff40d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0100\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_1101.jpg
magick.exe -size 256x256 -background "#0040e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0100\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_1110.jpg
magick.exe -size 256x256 -background "#ff40f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0100\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0100_1111.jpg
magick.exe -size 256x256 -background "#005000" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0101\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_0000.jpg
magick.exe -size 256x256 -background "#ff5010" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0101\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_0001.jpg
magick.exe -size 256x256 -background "#005020" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0101\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_0010.jpg
magick.exe -size 256x256 -background "#ff5030" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0101\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_0011.jpg
magick.exe -size 256x256 -background "#005040" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0101\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_0100.jpg
magick.exe -size 256x256 -background "#ff5050" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0101\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_0101.jpg
magick.exe -size 256x256 -background "#005060" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0101\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_0110.jpg
magick.exe -size 256x256 -background "#ff5070" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0101\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_0111.jpg
magick.exe -size 256x256 -background "#005080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0101\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_1000.jpg
magick.exe -size 256x256 -background "#ff5090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0101\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_1001.jpg
magick.exe -size 256x256 -background "#0050a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0101\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_1010.jpg
magick.exe -size 256x256 -background "#ff50b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0101\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_1011.jpg
magick.exe -size 256x256 -background "#0050c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0101\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_1100.jpg
magick.exe -size 256x256 -background "#ff50d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0101\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_1101.jpg
magick.exe -size 256x256 -background "#0050e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0101\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_1110.jpg
magick.exe -size 256x256 -background "#ff50f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0101\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0101_1111.jpg
magick.exe -size 256x256 -background "#006000" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0110\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_0000.jpg
magick.exe -size 256x256 -background "#ff6010" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0110\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_0001.jpg
magick.exe -size 256x256 -background "#006020" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0110\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_0010.jpg
magick.exe -size 256x256 -background "#ff6030" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0110\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_0011.jpg
magick.exe -size 256x256 -background "#006040" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0110\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_0100.jpg
magick.exe -size 256x256 -background "#ff6050" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0110\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_0101.jpg
magick.exe -size 256x256 -background "#006060" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0110\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_0110.jpg
magick.exe -size 256x256 -background "#ff6070" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0110\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_0111.jpg
magick.exe -size 256x256 -background "#006080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0110\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_1000.jpg
magick.exe -size 256x256 -background "#ff6090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0110\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_1001.jpg
magick.exe -size 256x256 -background "#0060a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0110\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_1010.jpg
magick.exe -size 256x256 -background "#ff60b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0110\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_1011.jpg
magick.exe -size 256x256 -background "#0060c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0110\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_1100.jpg
magick.exe -size 256x256 -background "#ff60d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0110\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_1101.jpg
magick.exe -size 256x256 -background "#0060e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0110\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_1110.jpg
magick.exe -size 256x256 -background "#ff60f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0110\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0110_1111.jpg
magick.exe -size 256x256 -background "#007000" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0111\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_0000.jpg
magick.exe -size 256x256 -background "#ff7010" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0111\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_0001.jpg
magick.exe -size 256x256 -background "#007020" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0111\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_0010.jpg
magick.exe -size 256x256 -background "#ff7030" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0111\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_0011.jpg
magick.exe -size 256x256 -background "#007040" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0111\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_0100.jpg
magick.exe -size 256x256 -background "#ff7050" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0111\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_0101.jpg
magick.exe -size 256x256 -background "#007060" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0111\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_0110.jpg
magick.exe -size 256x256 -background "#ff7070" -fill "#ffffff" -gravity center -pointsize 60 caption:"1\n0111\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_0111.jpg
magick.exe -size 256x256 -background "#007080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0111\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_1000.jpg
magick.exe -size 256x256 -background "#ff7090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0111\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_1001.jpg
magick.exe -size 256x256 -background "#0070a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0111\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_1010.jpg
magick.exe -size 256x256 -background "#ff70b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0111\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_1011.jpg
magick.exe -size 256x256 -background "#0070c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0111\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_1100.jpg
magick.exe -size 256x256 -background "#ff70d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0111\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_1101.jpg
magick.exe -size 256x256 -background "#0070e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0111\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_1110.jpg
magick.exe -size 256x256 -background "#ff70f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n0111\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_0111_1111.jpg
magick.exe -size 256x256 -background "#008000" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_0000.jpg
magick.exe -size 256x256 -background "#ff8010" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_0001.jpg
magick.exe -size 256x256 -background "#008020" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_0010.jpg
magick.exe -size 256x256 -background "#ff8030" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_0011.jpg
magick.exe -size 256x256 -background "#008040" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_0100.jpg
magick.exe -size 256x256 -background "#ff8050" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_0101.jpg
magick.exe -size 256x256 -background "#008060" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_0110.jpg
magick.exe -size 256x256 -background "#ff8070" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_0111.jpg
magick.exe -size 256x256 -background "#008080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_1000.jpg
magick.exe -size 256x256 -background "#ff8090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_1001.jpg
magick.exe -size 256x256 -background "#0080a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_1010.jpg
magick.exe -size 256x256 -background "#ff80b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_1011.jpg
magick.exe -size 256x256 -background "#0080c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_1100.jpg
magick.exe -size 256x256 -background "#ff80d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_1101.jpg
magick.exe -size 256x256 -background "#0080e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_1110.jpg
magick.exe -size 256x256 -background "#ff80f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1000\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1000_1111.jpg
magick.exe -size 256x256 -background "#009000" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_0000.jpg
magick.exe -size 256x256 -background "#ff9010" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_0001.jpg
magick.exe -size 256x256 -background "#009020" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_0010.jpg
magick.exe -size 256x256 -background "#ff9030" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_0011.jpg
magick.exe -size 256x256 -background "#009040" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_0100.jpg
magick.exe -size 256x256 -background "#ff9050" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_0101.jpg
magick.exe -size 256x256 -background "#009060" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_0110.jpg
magick.exe -size 256x256 -background "#ff9070" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_0111.jpg
magick.exe -size 256x256 -background "#009080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_1000.jpg
magick.exe -size 256x256 -background "#ff9090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_1001.jpg
magick.exe -size 256x256 -background "#0090a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_1010.jpg
magick.exe -size 256x256 -background "#ff90b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_1011.jpg
magick.exe -size 256x256 -background "#0090c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_1100.jpg
magick.exe -size 256x256 -background "#ff90d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_1101.jpg
magick.exe -size 256x256 -background "#0090e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_1110.jpg
magick.exe -size 256x256 -background "#ff90f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1001\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1001_1111.jpg
magick.exe -size 256x256 -background "#00a000" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_0000.jpg
magick.exe -size 256x256 -background "#ffa010" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_0001.jpg
magick.exe -size 256x256 -background "#00a020" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_0010.jpg
magick.exe -size 256x256 -background "#ffa030" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_0011.jpg
magick.exe -size 256x256 -background "#00a040" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_0100.jpg
magick.exe -size 256x256 -background "#ffa050" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_0101.jpg
magick.exe -size 256x256 -background "#00a060" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_0110.jpg
magick.exe -size 256x256 -background "#ffa070" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_0111.jpg
magick.exe -size 256x256 -background "#00a080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_1000.jpg
magick.exe -size 256x256 -background "#ffa090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_1001.jpg
magick.exe -size 256x256 -background "#00a0a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_1010.jpg
magick.exe -size 256x256 -background "#ffa0b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_1011.jpg
magick.exe -size 256x256 -background "#00a0c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_1100.jpg
magick.exe -size 256x256 -background "#ffa0d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_1101.jpg
magick.exe -size 256x256 -background "#00a0e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_1110.jpg
magick.exe -size 256x256 -background "#ffa0f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1010\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1010_1111.jpg
magick.exe -size 256x256 -background "#00b000" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_0000.jpg
magick.exe -size 256x256 -background "#ffb010" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_0001.jpg
magick.exe -size 256x256 -background "#00b020" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_0010.jpg
magick.exe -size 256x256 -background "#ffb030" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_0011.jpg
magick.exe -size 256x256 -background "#00b040" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_0100.jpg
magick.exe -size 256x256 -background "#ffb050" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_0101.jpg
magick.exe -size 256x256 -background "#00b060" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_0110.jpg
magick.exe -size 256x256 -background "#ffb070" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_0111.jpg
magick.exe -size 256x256 -background "#00b080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_1000.jpg
magick.exe -size 256x256 -background "#ffb090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_1001.jpg
magick.exe -size 256x256 -background "#00b0a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_1010.jpg
magick.exe -size 256x256 -background "#ffb0b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_1011.jpg
magick.exe -size 256x256 -background "#00b0c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_1100.jpg
magick.exe -size 256x256 -background "#ffb0d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_1101.jpg
magick.exe -size 256x256 -background "#00b0e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_1110.jpg
magick.exe -size 256x256 -background "#ffb0f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1011\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1011_1111.jpg
magick.exe -size 256x256 -background "#00c000" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_0000.jpg
magick.exe -size 256x256 -background "#ffc010" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_0001.jpg
magick.exe -size 256x256 -background "#00c020" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_0010.jpg
magick.exe -size 256x256 -background "#ffc030" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_0011.jpg
magick.exe -size 256x256 -background "#00c040" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_0100.jpg
magick.exe -size 256x256 -background "#ffc050" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_0101.jpg
magick.exe -size 256x256 -background "#00c060" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_0110.jpg
magick.exe -size 256x256 -background "#ffc070" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_0111.jpg
magick.exe -size 256x256 -background "#00c080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_1000.jpg
magick.exe -size 256x256 -background "#ffc090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_1001.jpg
magick.exe -size 256x256 -background "#00c0a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_1010.jpg
magick.exe -size 256x256 -background "#ffc0b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_1011.jpg
magick.exe -size 256x256 -background "#00c0c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_1100.jpg
magick.exe -size 256x256 -background "#ffc0d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_1101.jpg
magick.exe -size 256x256 -background "#00c0e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_1110.jpg
magick.exe -size 256x256 -background "#ffc0f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1100\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1100_1111.jpg
magick.exe -size 256x256 -background "#00d000" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_0000.jpg
magick.exe -size 256x256 -background "#ffd010" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_0001.jpg
magick.exe -size 256x256 -background "#00d020" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_0010.jpg
magick.exe -size 256x256 -background "#ffd030" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_0011.jpg
magick.exe -size 256x256 -background "#00d040" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_0100.jpg
magick.exe -size 256x256 -background "#ffd050" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_0101.jpg
magick.exe -size 256x256 -background "#00d060" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_0110.jpg
magick.exe -size 256x256 -background "#ffd070" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_0111.jpg
magick.exe -size 256x256 -background "#00d080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_1000.jpg
magick.exe -size 256x256 -background "#ffd090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_1001.jpg
magick.exe -size 256x256 -background "#00d0a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_1010.jpg
magick.exe -size 256x256 -background "#ffd0b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_1011.jpg
magick.exe -size 256x256 -background "#00d0c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_1100.jpg
magick.exe -size 256x256 -background "#ffd0d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_1101.jpg
magick.exe -size 256x256 -background "#00d0e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_1110.jpg
magick.exe -size 256x256 -background "#ffd0f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1101\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1101_1111.jpg
magick.exe -size 256x256 -background "#00e000" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_0000.jpg
magick.exe -size 256x256 -background "#ffe010" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_0001.jpg
magick.exe -size 256x256 -background "#00e020" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_0010.jpg
magick.exe -size 256x256 -background "#ffe030" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_0011.jpg
magick.exe -size 256x256 -background "#00e040" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_0100.jpg
magick.exe -size 256x256 -background "#ffe050" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_0101.jpg
magick.exe -size 256x256 -background "#00e060" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_0110.jpg
magick.exe -size 256x256 -background "#ffe070" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_0111.jpg
magick.exe -size 256x256 -background "#00e080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_1000.jpg
magick.exe -size 256x256 -background "#ffe090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_1001.jpg
magick.exe -size 256x256 -background "#00e0a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_1010.jpg
magick.exe -size 256x256 -background "#ffe0b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_1011.jpg
magick.exe -size 256x256 -background "#00e0c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_1100.jpg
magick.exe -size 256x256 -background "#ffe0d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_1101.jpg
magick.exe -size 256x256 -background "#00e0e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_1110.jpg
magick.exe -size 256x256 -background "#ffe0f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1110\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1110_1111.jpg
magick.exe -size 256x256 -background "#00f000" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_0000.jpg
magick.exe -size 256x256 -background "#fff010" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_0001.jpg
magick.exe -size 256x256 -background "#00f020" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_0010.jpg
magick.exe -size 256x256 -background "#fff030" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_0011.jpg
magick.exe -size 256x256 -background "#00f040" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_0100.jpg
magick.exe -size 256x256 -background "#fff050" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_0101.jpg
magick.exe -size 256x256 -background "#00f060" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_0110.jpg
magick.exe -size 256x256 -background "#fff070" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_0111.jpg
magick.exe -size 256x256 -background "#00f080" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_1000.jpg
magick.exe -size 256x256 -background "#fff090" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_1001.jpg
magick.exe -size 256x256 -background "#00f0a0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_1010.jpg
magick.exe -size 256x256 -background "#fff0b0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_1011.jpg
magick.exe -size 256x256 -background "#00f0c0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_1100.jpg
magick.exe -size 256x256 -background "#fff0d0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_1101.jpg
magick.exe -size 256x256 -background "#00f0e0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_1110.jpg
magick.exe -size 256x256 -background "#fff0f0" -fill "#000000" -gravity center -pointsize 60 caption:"1\n1111\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 1_1111_1111.jpg
magick.exe -size 256x256 -background "#000000" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0000\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_0000.jpg
magick.exe -size 256x256 -background "#ff0010" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0000\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_0001.jpg
magick.exe -size 256x256 -background "#000020" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0000\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_0010.jpg
magick.exe -size 256x256 -background "#ff0030" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0000\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_0011.jpg
magick.exe -size 256x256 -background "#000040" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0000\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_0100.jpg
magick.exe -size 256x256 -background "#ff0050" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0000\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_0101.jpg
magick.exe -size 256x256 -background "#000060" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0000\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_0110.jpg
magick.exe -size 256x256 -background "#ff0070" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0000\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_0111.jpg
magick.exe -size 256x256 -background "#000080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0000\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_1000.jpg
magick.exe -size 256x256 -background "#ff0090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0000\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_1001.jpg
magick.exe -size 256x256 -background "#0000a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0000\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_1010.jpg
magick.exe -size 256x256 -background "#ff00b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0000\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_1011.jpg
magick.exe -size 256x256 -background "#0000c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0000\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_1100.jpg
magick.exe -size 256x256 -background "#ff00d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0000\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_1101.jpg
magick.exe -size 256x256 -background "#0000e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0000\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_1110.jpg
magick.exe -size 256x256 -background "#ff00f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0000\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0000_1111.jpg
magick.exe -size 256x256 -background "#001000" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0001\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_0000.jpg
magick.exe -size 256x256 -background "#ff1010" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0001\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_0001.jpg
magick.exe -size 256x256 -background "#001020" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0001\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_0010.jpg
magick.exe -size 256x256 -background "#ff1030" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0001\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_0011.jpg
magick.exe -size 256x256 -background "#001040" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0001\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_0100.jpg
magick.exe -size 256x256 -background "#ff1050" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0001\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_0101.jpg
magick.exe -size 256x256 -background "#001060" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0001\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_0110.jpg
magick.exe -size 256x256 -background "#ff1070" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0001\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_0111.jpg
magick.exe -size 256x256 -background "#001080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0001\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_1000.jpg
magick.exe -size 256x256 -background "#ff1090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0001\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_1001.jpg
magick.exe -size 256x256 -background "#0010a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0001\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_1010.jpg
magick.exe -size 256x256 -background "#ff10b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0001\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_1011.jpg
magick.exe -size 256x256 -background "#0010c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0001\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_1100.jpg
magick.exe -size 256x256 -background "#ff10d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0001\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_1101.jpg
magick.exe -size 256x256 -background "#0010e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0001\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_1110.jpg
magick.exe -size 256x256 -background "#ff10f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0001\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0001_1111.jpg
magick.exe -size 256x256 -background "#002000" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0010\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_0000.jpg
magick.exe -size 256x256 -background "#ff2010" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0010\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_0001.jpg
magick.exe -size 256x256 -background "#002020" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0010\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_0010.jpg
magick.exe -size 256x256 -background "#ff2030" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0010\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_0011.jpg
magick.exe -size 256x256 -background "#002040" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0010\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_0100.jpg
magick.exe -size 256x256 -background "#ff2050" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0010\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_0101.jpg
magick.exe -size 256x256 -background "#002060" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0010\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_0110.jpg
magick.exe -size 256x256 -background "#ff2070" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0010\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_0111.jpg
magick.exe -size 256x256 -background "#002080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0010\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_1000.jpg
magick.exe -size 256x256 -background "#ff2090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0010\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_1001.jpg
magick.exe -size 256x256 -background "#0020a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0010\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_1010.jpg
magick.exe -size 256x256 -background "#ff20b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0010\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_1011.jpg
magick.exe -size 256x256 -background "#0020c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0010\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_1100.jpg
magick.exe -size 256x256 -background "#ff20d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0010\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_1101.jpg
magick.exe -size 256x256 -background "#0020e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0010\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_1110.jpg
magick.exe -size 256x256 -background "#ff20f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0010\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0010_1111.jpg
magick.exe -size 256x256 -background "#003000" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0011\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_0000.jpg
magick.exe -size 256x256 -background "#ff3010" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0011\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_0001.jpg
magick.exe -size 256x256 -background "#003020" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0011\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_0010.jpg
magick.exe -size 256x256 -background "#ff3030" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0011\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_0011.jpg
magick.exe -size 256x256 -background "#003040" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0011\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_0100.jpg
magick.exe -size 256x256 -background "#ff3050" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0011\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_0101.jpg
magick.exe -size 256x256 -background "#003060" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0011\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_0110.jpg
magick.exe -size 256x256 -background "#ff3070" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0011\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_0111.jpg
magick.exe -size 256x256 -background "#003080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0011\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_1000.jpg
magick.exe -size 256x256 -background "#ff3090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0011\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_1001.jpg
magick.exe -size 256x256 -background "#0030a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0011\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_1010.jpg
magick.exe -size 256x256 -background "#ff30b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0011\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_1011.jpg
magick.exe -size 256x256 -background "#0030c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0011\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_1100.jpg
magick.exe -size 256x256 -background "#ff30d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0011\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_1101.jpg
magick.exe -size 256x256 -background "#0030e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0011\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_1110.jpg
magick.exe -size 256x256 -background "#ff30f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0011\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0011_1111.jpg
magick.exe -size 256x256 -background "#004000" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0100\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_0000.jpg
magick.exe -size 256x256 -background "#ff4010" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0100\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_0001.jpg
magick.exe -size 256x256 -background "#004020" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0100\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_0010.jpg
magick.exe -size 256x256 -background "#ff4030" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0100\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_0011.jpg
magick.exe -size 256x256 -background "#004040" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0100\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_0100.jpg
magick.exe -size 256x256 -background "#ff4050" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0100\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_0101.jpg
magick.exe -size 256x256 -background "#004060" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0100\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_0110.jpg
magick.exe -size 256x256 -background "#ff4070" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0100\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_0111.jpg
magick.exe -size 256x256 -background "#004080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0100\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_1000.jpg
magick.exe -size 256x256 -background "#ff4090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0100\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_1001.jpg
magick.exe -size 256x256 -background "#0040a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0100\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_1010.jpg
magick.exe -size 256x256 -background "#ff40b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0100\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_1011.jpg
magick.exe -size 256x256 -background "#0040c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0100\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_1100.jpg
magick.exe -size 256x256 -background "#ff40d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0100\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_1101.jpg
magick.exe -size 256x256 -background "#0040e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0100\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_1110.jpg
magick.exe -size 256x256 -background "#ff40f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0100\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0100_1111.jpg
magick.exe -size 256x256 -background "#005000" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0101\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_0000.jpg
magick.exe -size 256x256 -background "#ff5010" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0101\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_0001.jpg
magick.exe -size 256x256 -background "#005020" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0101\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_0010.jpg
magick.exe -size 256x256 -background "#ff5030" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0101\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_0011.jpg
magick.exe -size 256x256 -background "#005040" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0101\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_0100.jpg
magick.exe -size 256x256 -background "#ff5050" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0101\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_0101.jpg
magick.exe -size 256x256 -background "#005060" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0101\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_0110.jpg
magick.exe -size 256x256 -background "#ff5070" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0101\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_0111.jpg
magick.exe -size 256x256 -background "#005080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0101\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_1000.jpg
magick.exe -size 256x256 -background "#ff5090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0101\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_1001.jpg
magick.exe -size 256x256 -background "#0050a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0101\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_1010.jpg
magick.exe -size 256x256 -background "#ff50b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0101\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_1011.jpg
magick.exe -size 256x256 -background "#0050c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0101\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_1100.jpg
magick.exe -size 256x256 -background "#ff50d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0101\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_1101.jpg
magick.exe -size 256x256 -background "#0050e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0101\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_1110.jpg
magick.exe -size 256x256 -background "#ff50f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0101\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0101_1111.jpg
magick.exe -size 256x256 -background "#006000" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0110\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_0000.jpg
magick.exe -size 256x256 -background "#ff6010" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0110\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_0001.jpg
magick.exe -size 256x256 -background "#006020" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0110\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_0010.jpg
magick.exe -size 256x256 -background "#ff6030" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0110\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_0011.jpg
magick.exe -size 256x256 -background "#006040" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0110\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_0100.jpg
magick.exe -size 256x256 -background "#ff6050" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0110\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_0101.jpg
magick.exe -size 256x256 -background "#006060" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0110\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_0110.jpg
magick.exe -size 256x256 -background "#ff6070" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0110\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_0111.jpg
magick.exe -size 256x256 -background "#006080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0110\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_1000.jpg
magick.exe -size 256x256 -background "#ff6090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0110\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_1001.jpg
magick.exe -size 256x256 -background "#0060a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0110\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_1010.jpg
magick.exe -size 256x256 -background "#ff60b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0110\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_1011.jpg
magick.exe -size 256x256 -background "#0060c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0110\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_1100.jpg
magick.exe -size 256x256 -background "#ff60d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0110\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_1101.jpg
magick.exe -size 256x256 -background "#0060e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0110\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_1110.jpg
magick.exe -size 256x256 -background "#ff60f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0110\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0110_1111.jpg
magick.exe -size 256x256 -background "#007000" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0111\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_0000.jpg
magick.exe -size 256x256 -background "#ff7010" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0111\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_0001.jpg
magick.exe -size 256x256 -background "#007020" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0111\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_0010.jpg
magick.exe -size 256x256 -background "#ff7030" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0111\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_0011.jpg
magick.exe -size 256x256 -background "#007040" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0111\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_0100.jpg
magick.exe -size 256x256 -background "#ff7050" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0111\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_0101.jpg
magick.exe -size 256x256 -background "#007060" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0111\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_0110.jpg
magick.exe -size 256x256 -background "#ff7070" -fill "#ffffff" -gravity center -pointsize 60 caption:"2\n0111\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_0111.jpg
magick.exe -size 256x256 -background "#007080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0111\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_1000.jpg
magick.exe -size 256x256 -background "#ff7090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0111\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_1001.jpg
magick.exe -size 256x256 -background "#0070a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0111\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_1010.jpg
magick.exe -size 256x256 -background "#ff70b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0111\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_1011.jpg
magick.exe -size 256x256 -background "#0070c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0111\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_1100.jpg
magick.exe -size 256x256 -background "#ff70d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0111\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_1101.jpg
magick.exe -size 256x256 -background "#0070e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0111\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_1110.jpg
magick.exe -size 256x256 -background "#ff70f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n0111\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_0111_1111.jpg
magick.exe -size 256x256 -background "#008000" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_0000.jpg
magick.exe -size 256x256 -background "#ff8010" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_0001.jpg
magick.exe -size 256x256 -background "#008020" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_0010.jpg
magick.exe -size 256x256 -background "#ff8030" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_0011.jpg
magick.exe -size 256x256 -background "#008040" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_0100.jpg
magick.exe -size 256x256 -background "#ff8050" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_0101.jpg
magick.exe -size 256x256 -background "#008060" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_0110.jpg
magick.exe -size 256x256 -background "#ff8070" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_0111.jpg
magick.exe -size 256x256 -background "#008080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_1000.jpg
magick.exe -size 256x256 -background "#ff8090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_1001.jpg
magick.exe -size 256x256 -background "#0080a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_1010.jpg
magick.exe -size 256x256 -background "#ff80b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_1011.jpg
magick.exe -size 256x256 -background "#0080c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_1100.jpg
magick.exe -size 256x256 -background "#ff80d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_1101.jpg
magick.exe -size 256x256 -background "#0080e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_1110.jpg
magick.exe -size 256x256 -background "#ff80f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1000\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1000_1111.jpg
magick.exe -size 256x256 -background "#009000" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_0000.jpg
magick.exe -size 256x256 -background "#ff9010" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_0001.jpg
magick.exe -size 256x256 -background "#009020" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_0010.jpg
magick.exe -size 256x256 -background "#ff9030" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_0011.jpg
magick.exe -size 256x256 -background "#009040" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_0100.jpg
magick.exe -size 256x256 -background "#ff9050" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_0101.jpg
magick.exe -size 256x256 -background "#009060" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_0110.jpg
magick.exe -size 256x256 -background "#ff9070" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_0111.jpg
magick.exe -size 256x256 -background "#009080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_1000.jpg
magick.exe -size 256x256 -background "#ff9090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_1001.jpg
magick.exe -size 256x256 -background "#0090a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_1010.jpg
magick.exe -size 256x256 -background "#ff90b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_1011.jpg
magick.exe -size 256x256 -background "#0090c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_1100.jpg
magick.exe -size 256x256 -background "#ff90d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_1101.jpg
magick.exe -size 256x256 -background "#0090e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_1110.jpg
magick.exe -size 256x256 -background "#ff90f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1001\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1001_1111.jpg
magick.exe -size 256x256 -background "#00a000" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_0000.jpg
magick.exe -size 256x256 -background "#ffa010" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_0001.jpg
magick.exe -size 256x256 -background "#00a020" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_0010.jpg
magick.exe -size 256x256 -background "#ffa030" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_0011.jpg
magick.exe -size 256x256 -background "#00a040" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_0100.jpg
magick.exe -size 256x256 -background "#ffa050" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_0101.jpg
magick.exe -size 256x256 -background "#00a060" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_0110.jpg
magick.exe -size 256x256 -background "#ffa070" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_0111.jpg
magick.exe -size 256x256 -background "#00a080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_1000.jpg
magick.exe -size 256x256 -background "#ffa090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_1001.jpg
magick.exe -size 256x256 -background "#00a0a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_1010.jpg
magick.exe -size 256x256 -background "#ffa0b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_1011.jpg
magick.exe -size 256x256 -background "#00a0c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_1100.jpg
magick.exe -size 256x256 -background "#ffa0d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_1101.jpg
magick.exe -size 256x256 -background "#00a0e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_1110.jpg
magick.exe -size 256x256 -background "#ffa0f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1010\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1010_1111.jpg
magick.exe -size 256x256 -background "#00b000" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_0000.jpg
magick.exe -size 256x256 -background "#ffb010" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_0001.jpg
magick.exe -size 256x256 -background "#00b020" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_0010.jpg
magick.exe -size 256x256 -background "#ffb030" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_0011.jpg
magick.exe -size 256x256 -background "#00b040" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_0100.jpg
magick.exe -size 256x256 -background "#ffb050" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_0101.jpg
magick.exe -size 256x256 -background "#00b060" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_0110.jpg
magick.exe -size 256x256 -background "#ffb070" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_0111.jpg
magick.exe -size 256x256 -background "#00b080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_1000.jpg
magick.exe -size 256x256 -background "#ffb090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_1001.jpg
magick.exe -size 256x256 -background "#00b0a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_1010.jpg
magick.exe -size 256x256 -background "#ffb0b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_1011.jpg
magick.exe -size 256x256 -background "#00b0c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_1100.jpg
magick.exe -size 256x256 -background "#ffb0d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_1101.jpg
magick.exe -size 256x256 -background "#00b0e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_1110.jpg
magick.exe -size 256x256 -background "#ffb0f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1011\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1011_1111.jpg
magick.exe -size 256x256 -background "#00c000" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_0000.jpg
magick.exe -size 256x256 -background "#ffc010" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_0001.jpg
magick.exe -size 256x256 -background "#00c020" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_0010.jpg
magick.exe -size 256x256 -background "#ffc030" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_0011.jpg
magick.exe -size 256x256 -background "#00c040" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_0100.jpg
magick.exe -size 256x256 -background "#ffc050" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_0101.jpg
magick.exe -size 256x256 -background "#00c060" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_0110.jpg
magick.exe -size 256x256 -background "#ffc070" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_0111.jpg
magick.exe -size 256x256 -background "#00c080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_1000.jpg
magick.exe -size 256x256 -background "#ffc090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_1001.jpg
magick.exe -size 256x256 -background "#00c0a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_1010.jpg
magick.exe -size 256x256 -background "#ffc0b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_1011.jpg
magick.exe -size 256x256 -background "#00c0c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_1100.jpg
magick.exe -size 256x256 -background "#ffc0d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_1101.jpg
magick.exe -size 256x256 -background "#00c0e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_1110.jpg
magick.exe -size 256x256 -background "#ffc0f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1100\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1100_1111.jpg
magick.exe -size 256x256 -background "#00d000" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_0000.jpg
magick.exe -size 256x256 -background "#ffd010" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_0001.jpg
magick.exe -size 256x256 -background "#00d020" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_0010.jpg
magick.exe -size 256x256 -background "#ffd030" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_0011.jpg
magick.exe -size 256x256 -background "#00d040" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_0100.jpg
magick.exe -size 256x256 -background "#ffd050" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_0101.jpg
magick.exe -size 256x256 -background "#00d060" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_0110.jpg
magick.exe -size 256x256 -background "#ffd070" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_0111.jpg
magick.exe -size 256x256 -background "#00d080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_1000.jpg
magick.exe -size 256x256 -background "#ffd090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_1001.jpg
magick.exe -size 256x256 -background "#00d0a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_1010.jpg
magick.exe -size 256x256 -background "#ffd0b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_1011.jpg
magick.exe -size 256x256 -background "#00d0c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_1100.jpg
magick.exe -size 256x256 -background "#ffd0d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_1101.jpg
magick.exe -size 256x256 -background "#00d0e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_1110.jpg
magick.exe -size 256x256 -background "#ffd0f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1101\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1101_1111.jpg
magick.exe -size 256x256 -background "#00e000" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_0000.jpg
magick.exe -size 256x256 -background "#ffe010" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_0001.jpg
magick.exe -size 256x256 -background "#00e020" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_0010.jpg
magick.exe -size 256x256 -background "#ffe030" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_0011.jpg
magick.exe -size 256x256 -background "#00e040" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_0100.jpg
magick.exe -size 256x256 -background "#ffe050" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_0101.jpg
magick.exe -size 256x256 -background "#00e060" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_0110.jpg
magick.exe -size 256x256 -background "#ffe070" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_0111.jpg
magick.exe -size 256x256 -background "#00e080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_1000.jpg
magick.exe -size 256x256 -background "#ffe090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_1001.jpg
magick.exe -size 256x256 -background "#00e0a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_1010.jpg
magick.exe -size 256x256 -background "#ffe0b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_1011.jpg
magick.exe -size 256x256 -background "#00e0c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_1100.jpg
magick.exe -size 256x256 -background "#ffe0d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_1101.jpg
magick.exe -size 256x256 -background "#00e0e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_1110.jpg
magick.exe -size 256x256 -background "#ffe0f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1110\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1110_1111.jpg
magick.exe -size 256x256 -background "#00f000" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_0000.jpg
magick.exe -size 256x256 -background "#fff010" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_0001.jpg
magick.exe -size 256x256 -background "#00f020" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_0010.jpg
magick.exe -size 256x256 -background "#fff030" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_0011.jpg
magick.exe -size 256x256 -background "#00f040" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_0100.jpg
magick.exe -size 256x256 -background "#fff050" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_0101.jpg
magick.exe -size 256x256 -background "#00f060" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_0110.jpg
magick.exe -size 256x256 -background "#fff070" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_0111.jpg
magick.exe -size 256x256 -background "#00f080" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_1000.jpg
magick.exe -size 256x256 -background "#fff090" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_1001.jpg
magick.exe -size 256x256 -background "#00f0a0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_1010.jpg
magick.exe -size 256x256 -background "#fff0b0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_1011.jpg
magick.exe -size 256x256 -background "#00f0c0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_1100.jpg
magick.exe -size 256x256 -background "#fff0d0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_1101.jpg
magick.exe -size 256x256 -background "#00f0e0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_1110.jpg
magick.exe -size 256x256 -background "#fff0f0" -fill "#000000" -gravity center -pointsize 60 caption:"2\n1111\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 2_1111_1111.jpg
magick.exe -size 256x256 -background "#000000" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0000\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_0000.jpg
magick.exe -size 256x256 -background "#ff0010" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0000\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_0001.jpg
magick.exe -size 256x256 -background "#000020" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0000\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_0010.jpg
magick.exe -size 256x256 -background "#ff0030" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0000\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_0011.jpg
magick.exe -size 256x256 -background "#000040" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0000\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_0100.jpg
magick.exe -size 256x256 -background "#ff0050" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0000\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_0101.jpg
magick.exe -size 256x256 -background "#000060" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0000\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_0110.jpg
magick.exe -size 256x256 -background "#ff0070" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0000\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_0111.jpg
magick.exe -size 256x256 -background "#000080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0000\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_1000.jpg
magick.exe -size 256x256 -background "#ff0090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0000\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_1001.jpg
magick.exe -size 256x256 -background "#0000a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0000\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_1010.jpg
magick.exe -size 256x256 -background "#ff00b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0000\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_1011.jpg
magick.exe -size 256x256 -background "#0000c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0000\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_1100.jpg
magick.exe -size 256x256 -background "#ff00d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0000\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_1101.jpg
magick.exe -size 256x256 -background "#0000e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0000\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_1110.jpg
magick.exe -size 256x256 -background "#ff00f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0000\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0000_1111.jpg
magick.exe -size 256x256 -background "#001000" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0001\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_0000.jpg
magick.exe -size 256x256 -background "#ff1010" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0001\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_0001.jpg
magick.exe -size 256x256 -background "#001020" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0001\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_0010.jpg
magick.exe -size 256x256 -background "#ff1030" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0001\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_0011.jpg
magick.exe -size 256x256 -background "#001040" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0001\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_0100.jpg
magick.exe -size 256x256 -background "#ff1050" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0001\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_0101.jpg
magick.exe -size 256x256 -background "#001060" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0001\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_0110.jpg
magick.exe -size 256x256 -background "#ff1070" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0001\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_0111.jpg
magick.exe -size 256x256 -background "#001080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0001\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_1000.jpg
magick.exe -size 256x256 -background "#ff1090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0001\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_1001.jpg
magick.exe -size 256x256 -background "#0010a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0001\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_1010.jpg
magick.exe -size 256x256 -background "#ff10b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0001\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_1011.jpg
magick.exe -size 256x256 -background "#0010c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0001\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_1100.jpg
magick.exe -size 256x256 -background "#ff10d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0001\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_1101.jpg
magick.exe -size 256x256 -background "#0010e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0001\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_1110.jpg
magick.exe -size 256x256 -background "#ff10f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0001\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0001_1111.jpg
magick.exe -size 256x256 -background "#002000" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0010\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_0000.jpg
magick.exe -size 256x256 -background "#ff2010" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0010\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_0001.jpg
magick.exe -size 256x256 -background "#002020" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0010\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_0010.jpg
magick.exe -size 256x256 -background "#ff2030" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0010\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_0011.jpg
magick.exe -size 256x256 -background "#002040" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0010\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_0100.jpg
magick.exe -size 256x256 -background "#ff2050" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0010\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_0101.jpg
magick.exe -size 256x256 -background "#002060" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0010\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_0110.jpg
magick.exe -size 256x256 -background "#ff2070" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0010\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_0111.jpg
magick.exe -size 256x256 -background "#002080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0010\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_1000.jpg
magick.exe -size 256x256 -background "#ff2090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0010\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_1001.jpg
magick.exe -size 256x256 -background "#0020a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0010\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_1010.jpg
magick.exe -size 256x256 -background "#ff20b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0010\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_1011.jpg
magick.exe -size 256x256 -background "#0020c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0010\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_1100.jpg
magick.exe -size 256x256 -background "#ff20d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0010\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_1101.jpg
magick.exe -size 256x256 -background "#0020e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0010\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_1110.jpg
magick.exe -size 256x256 -background "#ff20f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0010\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0010_1111.jpg
magick.exe -size 256x256 -background "#003000" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0011\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_0000.jpg
magick.exe -size 256x256 -background "#ff3010" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0011\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_0001.jpg
magick.exe -size 256x256 -background "#003020" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0011\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_0010.jpg
magick.exe -size 256x256 -background "#ff3030" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0011\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_0011.jpg
magick.exe -size 256x256 -background "#003040" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0011\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_0100.jpg
magick.exe -size 256x256 -background "#ff3050" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0011\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_0101.jpg
magick.exe -size 256x256 -background "#003060" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0011\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_0110.jpg
magick.exe -size 256x256 -background "#ff3070" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0011\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_0111.jpg
magick.exe -size 256x256 -background "#003080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0011\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_1000.jpg
magick.exe -size 256x256 -background "#ff3090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0011\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_1001.jpg
magick.exe -size 256x256 -background "#0030a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0011\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_1010.jpg
magick.exe -size 256x256 -background "#ff30b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0011\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_1011.jpg
magick.exe -size 256x256 -background "#0030c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0011\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_1100.jpg
magick.exe -size 256x256 -background "#ff30d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0011\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_1101.jpg
magick.exe -size 256x256 -background "#0030e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0011\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_1110.jpg
magick.exe -size 256x256 -background "#ff30f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0011\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0011_1111.jpg
magick.exe -size 256x256 -background "#004000" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0100\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_0000.jpg
magick.exe -size 256x256 -background "#ff4010" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0100\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_0001.jpg
magick.exe -size 256x256 -background "#004020" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0100\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_0010.jpg
magick.exe -size 256x256 -background "#ff4030" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0100\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_0011.jpg
magick.exe -size 256x256 -background "#004040" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0100\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_0100.jpg
magick.exe -size 256x256 -background "#ff4050" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0100\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_0101.jpg
magick.exe -size 256x256 -background "#004060" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0100\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_0110.jpg
magick.exe -size 256x256 -background "#ff4070" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0100\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_0111.jpg
magick.exe -size 256x256 -background "#004080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0100\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_1000.jpg
magick.exe -size 256x256 -background "#ff4090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0100\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_1001.jpg
magick.exe -size 256x256 -background "#0040a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0100\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_1010.jpg
magick.exe -size 256x256 -background "#ff40b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0100\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_1011.jpg
magick.exe -size 256x256 -background "#0040c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0100\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_1100.jpg
magick.exe -size 256x256 -background "#ff40d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0100\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_1101.jpg
magick.exe -size 256x256 -background "#0040e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0100\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_1110.jpg
magick.exe -size 256x256 -background "#ff40f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0100\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0100_1111.jpg
magick.exe -size 256x256 -background "#005000" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0101\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_0000.jpg
magick.exe -size 256x256 -background "#ff5010" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0101\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_0001.jpg
magick.exe -size 256x256 -background "#005020" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0101\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_0010.jpg
magick.exe -size 256x256 -background "#ff5030" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0101\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_0011.jpg
magick.exe -size 256x256 -background "#005040" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0101\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_0100.jpg
magick.exe -size 256x256 -background "#ff5050" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0101\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_0101.jpg
magick.exe -size 256x256 -background "#005060" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0101\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_0110.jpg
magick.exe -size 256x256 -background "#ff5070" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0101\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_0111.jpg
magick.exe -size 256x256 -background "#005080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0101\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_1000.jpg
magick.exe -size 256x256 -background "#ff5090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0101\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_1001.jpg
magick.exe -size 256x256 -background "#0050a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0101\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_1010.jpg
magick.exe -size 256x256 -background "#ff50b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0101\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_1011.jpg
magick.exe -size 256x256 -background "#0050c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0101\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_1100.jpg
magick.exe -size 256x256 -background "#ff50d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0101\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_1101.jpg
magick.exe -size 256x256 -background "#0050e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0101\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_1110.jpg
magick.exe -size 256x256 -background "#ff50f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0101\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0101_1111.jpg
magick.exe -size 256x256 -background "#006000" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0110\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_0000.jpg
magick.exe -size 256x256 -background "#ff6010" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0110\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_0001.jpg
magick.exe -size 256x256 -background "#006020" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0110\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_0010.jpg
magick.exe -size 256x256 -background "#ff6030" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0110\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_0011.jpg
magick.exe -size 256x256 -background "#006040" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0110\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_0100.jpg
magick.exe -size 256x256 -background "#ff6050" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0110\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_0101.jpg
magick.exe -size 256x256 -background "#006060" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0110\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_0110.jpg
magick.exe -size 256x256 -background "#ff6070" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0110\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_0111.jpg
magick.exe -size 256x256 -background "#006080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0110\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_1000.jpg
magick.exe -size 256x256 -background "#ff6090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0110\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_1001.jpg
magick.exe -size 256x256 -background "#0060a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0110\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_1010.jpg
magick.exe -size 256x256 -background "#ff60b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0110\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_1011.jpg
magick.exe -size 256x256 -background "#0060c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0110\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_1100.jpg
magick.exe -size 256x256 -background "#ff60d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0110\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_1101.jpg
magick.exe -size 256x256 -background "#0060e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0110\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_1110.jpg
magick.exe -size 256x256 -background "#ff60f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0110\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0110_1111.jpg
magick.exe -size 256x256 -background "#007000" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0111\n0000" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_0000.jpg
magick.exe -size 256x256 -background "#ff7010" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0111\n0001" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_0001.jpg
magick.exe -size 256x256 -background "#007020" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0111\n0010" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_0010.jpg
magick.exe -size 256x256 -background "#ff7030" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0111\n0011" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_0011.jpg
magick.exe -size 256x256 -background "#007040" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0111\n0100" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_0100.jpg
magick.exe -size 256x256 -background "#ff7050" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0111\n0101" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_0101.jpg
magick.exe -size 256x256 -background "#007060" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0111\n0110" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_0110.jpg
magick.exe -size 256x256 -background "#ff7070" -fill "#ffffff" -gravity center -pointsize 60 caption:"3\n0111\n0111" -flatten -stroke "#ffffff" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_0111.jpg
magick.exe -size 256x256 -background "#007080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0111\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_1000.jpg
magick.exe -size 256x256 -background "#ff7090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0111\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_1001.jpg
magick.exe -size 256x256 -background "#0070a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0111\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_1010.jpg
magick.exe -size 256x256 -background "#ff70b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0111\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_1011.jpg
magick.exe -size 256x256 -background "#0070c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0111\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_1100.jpg
magick.exe -size 256x256 -background "#ff70d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0111\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_1101.jpg
magick.exe -size 256x256 -background "#0070e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0111\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_1110.jpg
magick.exe -size 256x256 -background "#ff70f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n0111\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_0111_1111.jpg
magick.exe -size 256x256 -background "#008000" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_0000.jpg
magick.exe -size 256x256 -background "#ff8010" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_0001.jpg
magick.exe -size 256x256 -background "#008020" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_0010.jpg
magick.exe -size 256x256 -background "#ff8030" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_0011.jpg
magick.exe -size 256x256 -background "#008040" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_0100.jpg
magick.exe -size 256x256 -background "#ff8050" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_0101.jpg
magick.exe -size 256x256 -background "#008060" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_0110.jpg
magick.exe -size 256x256 -background "#ff8070" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_0111.jpg
magick.exe -size 256x256 -background "#008080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_1000.jpg
magick.exe -size 256x256 -background "#ff8090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_1001.jpg
magick.exe -size 256x256 -background "#0080a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_1010.jpg
magick.exe -size 256x256 -background "#ff80b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_1011.jpg
magick.exe -size 256x256 -background "#0080c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_1100.jpg
magick.exe -size 256x256 -background "#ff80d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_1101.jpg
magick.exe -size 256x256 -background "#0080e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_1110.jpg
magick.exe -size 256x256 -background "#ff80f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1000\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1000_1111.jpg
magick.exe -size 256x256 -background "#009000" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_0000.jpg
magick.exe -size 256x256 -background "#ff9010" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_0001.jpg
magick.exe -size 256x256 -background "#009020" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_0010.jpg
magick.exe -size 256x256 -background "#ff9030" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_0011.jpg
magick.exe -size 256x256 -background "#009040" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_0100.jpg
magick.exe -size 256x256 -background "#ff9050" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_0101.jpg
magick.exe -size 256x256 -background "#009060" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_0110.jpg
magick.exe -size 256x256 -background "#ff9070" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_0111.jpg
magick.exe -size 256x256 -background "#009080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_1000.jpg
magick.exe -size 256x256 -background "#ff9090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_1001.jpg
magick.exe -size 256x256 -background "#0090a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_1010.jpg
magick.exe -size 256x256 -background "#ff90b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_1011.jpg
magick.exe -size 256x256 -background "#0090c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_1100.jpg
magick.exe -size 256x256 -background "#ff90d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_1101.jpg
magick.exe -size 256x256 -background "#0090e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_1110.jpg
magick.exe -size 256x256 -background "#ff90f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1001\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1001_1111.jpg
magick.exe -size 256x256 -background "#00a000" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_0000.jpg
magick.exe -size 256x256 -background "#ffa010" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_0001.jpg
magick.exe -size 256x256 -background "#00a020" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_0010.jpg
magick.exe -size 256x256 -background "#ffa030" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_0011.jpg
magick.exe -size 256x256 -background "#00a040" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_0100.jpg
magick.exe -size 256x256 -background "#ffa050" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_0101.jpg
magick.exe -size 256x256 -background "#00a060" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_0110.jpg
magick.exe -size 256x256 -background "#ffa070" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_0111.jpg
magick.exe -size 256x256 -background "#00a080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_1000.jpg
magick.exe -size 256x256 -background "#ffa090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_1001.jpg
magick.exe -size 256x256 -background "#00a0a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_1010.jpg
magick.exe -size 256x256 -background "#ffa0b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_1011.jpg
magick.exe -size 256x256 -background "#00a0c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_1100.jpg
magick.exe -size 256x256 -background "#ffa0d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_1101.jpg
magick.exe -size 256x256 -background "#00a0e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_1110.jpg
magick.exe -size 256x256 -background "#ffa0f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1010\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1010_1111.jpg
magick.exe -size 256x256 -background "#00b000" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_0000.jpg
magick.exe -size 256x256 -background "#ffb010" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_0001.jpg
magick.exe -size 256x256 -background "#00b020" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_0010.jpg
magick.exe -size 256x256 -background "#ffb030" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_0011.jpg
magick.exe -size 256x256 -background "#00b040" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_0100.jpg
magick.exe -size 256x256 -background "#ffb050" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_0101.jpg
magick.exe -size 256x256 -background "#00b060" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_0110.jpg
magick.exe -size 256x256 -background "#ffb070" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_0111.jpg
magick.exe -size 256x256 -background "#00b080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_1000.jpg
magick.exe -size 256x256 -background "#ffb090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_1001.jpg
magick.exe -size 256x256 -background "#00b0a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_1010.jpg
magick.exe -size 256x256 -background "#ffb0b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_1011.jpg
magick.exe -size 256x256 -background "#00b0c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_1100.jpg
magick.exe -size 256x256 -background "#ffb0d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_1101.jpg
magick.exe -size 256x256 -background "#00b0e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_1110.jpg
magick.exe -size 256x256 -background "#ffb0f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1011\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1011_1111.jpg
magick.exe -size 256x256 -background "#00c000" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_0000.jpg
magick.exe -size 256x256 -background "#ffc010" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_0001.jpg
magick.exe -size 256x256 -background "#00c020" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_0010.jpg
magick.exe -size 256x256 -background "#ffc030" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_0011.jpg
magick.exe -size 256x256 -background "#00c040" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_0100.jpg
magick.exe -size 256x256 -background "#ffc050" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_0101.jpg
magick.exe -size 256x256 -background "#00c060" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_0110.jpg
magick.exe -size 256x256 -background "#ffc070" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_0111.jpg
magick.exe -size 256x256 -background "#00c080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_1000.jpg
magick.exe -size 256x256 -background "#ffc090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_1001.jpg
magick.exe -size 256x256 -background "#00c0a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_1010.jpg
magick.exe -size 256x256 -background "#ffc0b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_1011.jpg
magick.exe -size 256x256 -background "#00c0c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_1100.jpg
magick.exe -size 256x256 -background "#ffc0d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_1101.jpg
magick.exe -size 256x256 -background "#00c0e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_1110.jpg
magick.exe -size 256x256 -background "#ffc0f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1100\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1100_1111.jpg
magick.exe -size 256x256 -background "#00d000" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_0000.jpg
magick.exe -size 256x256 -background "#ffd010" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_0001.jpg
magick.exe -size 256x256 -background "#00d020" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_0010.jpg
magick.exe -size 256x256 -background "#ffd030" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_0011.jpg
magick.exe -size 256x256 -background "#00d040" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_0100.jpg
magick.exe -size 256x256 -background "#ffd050" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_0101.jpg
magick.exe -size 256x256 -background "#00d060" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_0110.jpg
magick.exe -size 256x256 -background "#ffd070" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_0111.jpg
magick.exe -size 256x256 -background "#00d080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_1000.jpg
magick.exe -size 256x256 -background "#ffd090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_1001.jpg
magick.exe -size 256x256 -background "#00d0a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_1010.jpg
magick.exe -size 256x256 -background "#ffd0b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_1011.jpg
magick.exe -size 256x256 -background "#00d0c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_1100.jpg
magick.exe -size 256x256 -background "#ffd0d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_1101.jpg
magick.exe -size 256x256 -background "#00d0e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_1110.jpg
magick.exe -size 256x256 -background "#ffd0f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1101\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1101_1111.jpg
magick.exe -size 256x256 -background "#00e000" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_0000.jpg
magick.exe -size 256x256 -background "#ffe010" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_0001.jpg
magick.exe -size 256x256 -background "#00e020" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_0010.jpg
magick.exe -size 256x256 -background "#ffe030" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_0011.jpg
magick.exe -size 256x256 -background "#00e040" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_0100.jpg
magick.exe -size 256x256 -background "#ffe050" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_0101.jpg
magick.exe -size 256x256 -background "#00e060" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_0110.jpg
magick.exe -size 256x256 -background "#ffe070" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_0111.jpg
magick.exe -size 256x256 -background "#00e080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_1000.jpg
magick.exe -size 256x256 -background "#ffe090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_1001.jpg
magick.exe -size 256x256 -background "#00e0a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_1010.jpg
magick.exe -size 256x256 -background "#ffe0b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_1011.jpg
magick.exe -size 256x256 -background "#00e0c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_1100.jpg
magick.exe -size 256x256 -background "#ffe0d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_1101.jpg
magick.exe -size 256x256 -background "#00e0e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_1110.jpg
magick.exe -size 256x256 -background "#ffe0f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1110\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1110_1111.jpg
magick.exe -size 256x256 -background "#00f000" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n0000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_0000.jpg
magick.exe -size 256x256 -background "#fff010" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n0001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_0001.jpg
magick.exe -size 256x256 -background "#00f020" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n0010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_0010.jpg
magick.exe -size 256x256 -background "#fff030" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n0011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_0011.jpg
magick.exe -size 256x256 -background "#00f040" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n0100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_0100.jpg
magick.exe -size 256x256 -background "#fff050" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n0101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_0101.jpg
magick.exe -size 256x256 -background "#00f060" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n0110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_0110.jpg
magick.exe -size 256x256 -background "#fff070" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n0111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_0111.jpg
magick.exe -size 256x256 -background "#00f080" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n1000" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_1000.jpg
magick.exe -size 256x256 -background "#fff090" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n1001" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_1001.jpg
magick.exe -size 256x256 -background "#00f0a0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n1010" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_1010.jpg
magick.exe -size 256x256 -background "#fff0b0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n1011" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_1011.jpg
magick.exe -size 256x256 -background "#00f0c0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n1100" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_1100.jpg
magick.exe -size 256x256 -background "#fff0d0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n1101" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_1101.jpg
magick.exe -size 256x256 -background "#00f0e0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n1110" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_1110.jpg
magick.exe -size 256x256 -background "#fff0f0" -fill "#000000" -gravity center -pointsize 60 caption:"3\n1111\n1111" -flatten -stroke "#000000" -strokeWidth 4 -fill "#00000000" -draw "rectangle 0,0,255,255" 3_1111_1111.jpg
magick.exe montage 1_0000_0000.jpg 1_0000_0001.jpg 1_0001_0000.jpg 1_0001_0001.jpg  -geometry 128x128 1_000_000.jpg
magick.exe montage 1_0000_0010.jpg 1_0000_0011.jpg 1_0001_0010.jpg 1_0001_0011.jpg  -geometry 128x128 1_000_001.jpg
magick.exe montage 1_0000_0100.jpg 1_0000_0101.jpg 1_0001_0100.jpg 1_0001_0101.jpg  -geometry 128x128 1_000_010.jpg
magick.exe montage 1_0000_0110.jpg 1_0000_0111.jpg 1_0001_0110.jpg 1_0001_0111.jpg  -geometry 128x128 1_000_011.jpg
magick.exe montage 1_0000_1000.jpg 1_0000_1001.jpg 1_0001_1000.jpg 1_0001_1001.jpg  -geometry 128x128 1_000_100.jpg
magick.exe montage 1_0000_1010.jpg 1_0000_1011.jpg 1_0001_1010.jpg 1_0001_1011.jpg  -geometry 128x128 1_000_101.jpg
magick.exe montage 1_0000_1100.jpg 1_0000_1101.jpg 1_0001_1100.jpg 1_0001_1101.jpg  -geometry 128x128 1_000_110.jpg
magick.exe montage 1_0000_1110.jpg 1_0000_1111.jpg 1_0001_1110.jpg 1_0001_1111.jpg  -geometry 128x128 1_000_111.jpg
magick.exe montage 1_0010_0000.jpg 1_0010_0001.jpg 1_0011_0000.jpg 1_0011_0001.jpg  -geometry 128x128 1_001_000.jpg
magick.exe montage 1_0010_0010.jpg 1_0010_0011.jpg 1_0011_0010.jpg 1_0011_0011.jpg  -geometry 128x128 1_001_001.jpg
magick.exe montage 1_0010_0100.jpg 1_0010_0101.jpg 1_0011_0100.jpg 1_0011_0101.jpg  -geometry 128x128 1_001_010.jpg
magick.exe montage 1_0010_0110.jpg 1_0010_0111.jpg 1_0011_0110.jpg 1_0011_0111.jpg  -geometry 128x128 1_001_011.jpg
magick.exe montage 1_0010_1000.jpg 1_0010_1001.jpg 1_0011_1000.jpg 1_0011_1001.jpg  -geometry 128x128 1_001_100.jpg
magick.exe montage 1_0010_1010.jpg 1_0010_1011.jpg 1_0011_1010.jpg 1_0011_1011.jpg  -geometry 128x128 1_001_101.jpg
magick.exe montage 1_0010_1100.jpg 1_0010_1101.jpg 1_0011_1100.jpg 1_0011_1101.jpg  -geometry 128x128 1_001_110.jpg
magick.exe montage 1_0010_1110.jpg 1_0010_1111.jpg 1_0011_1110.jpg 1_0011_1111.jpg  -geometry 128x128 1_001_111.jpg
magick.exe montage 1_0100_0000.jpg 1_0100_0001.jpg 1_0101_0000.jpg 1_0101_0001.jpg  -geometry 128x128 1_010_000.jpg
magick.exe montage 1_0100_0010.jpg 1_0100_0011.jpg 1_0101_0010.jpg 1_0101_0011.jpg  -geometry 128x128 1_010_001.jpg
magick.exe montage 1_0100_0100.jpg 1_0100_0101.jpg 1_0101_0100.jpg 1_0101_0101.jpg  -geometry 128x128 1_010_010.jpg
magick.exe montage 1_0100_0110.jpg 1_0100_0111.jpg 1_0101_0110.jpg 1_0101_0111.jpg  -geometry 128x128 1_010_011.jpg
magick.exe montage 1_0100_1000.jpg 1_0100_1001.jpg 1_0101_1000.jpg 1_0101_1001.jpg  -geometry 128x128 1_010_100.jpg
magick.exe montage 1_0100_1010.jpg 1_0100_1011.jpg 1_0101_1010.jpg 1_0101_1011.jpg  -geometry 128x128 1_010_101.jpg
magick.exe montage 1_0100_1100.jpg 1_0100_1101.jpg 1_0101_1100.jpg 1_0101_1101.jpg  -geometry 128x128 1_010_110.jpg
magick.exe montage 1_0100_1110.jpg 1_0100_1111.jpg 1_0101_1110.jpg 1_0101_1111.jpg  -geometry 128x128 1_010_111.jpg
magick.exe montage 1_0110_0000.jpg 1_0110_0001.jpg 1_0111_0000.jpg 1_0111_0001.jpg  -geometry 128x128 1_011_000.jpg
magick.exe montage 1_0110_0010.jpg 1_0110_0011.jpg 1_0111_0010.jpg 1_0111_0011.jpg  -geometry 128x128 1_011_001.jpg
magick.exe montage 1_0110_0100.jpg 1_0110_0101.jpg 1_0111_0100.jpg 1_0111_0101.jpg  -geometry 128x128 1_011_010.jpg
magick.exe montage 1_0110_0110.jpg 1_0110_0111.jpg 1_0111_0110.jpg 1_0111_0111.jpg  -geometry 128x128 1_011_011.jpg
magick.exe montage 1_0110_1000.jpg 1_0110_1001.jpg 1_0111_1000.jpg 1_0111_1001.jpg  -geometry 128x128 1_011_100.jpg
magick.exe montage 1_0110_1010.jpg 1_0110_1011.jpg 1_0111_1010.jpg 1_0111_1011.jpg  -geometry 128x128 1_011_101.jpg
magick.exe montage 1_0110_1100.jpg 1_0110_1101.jpg 1_0111_1100.jpg 1_0111_1101.jpg  -geometry 128x128 1_011_110.jpg
magick.exe montage 1_0110_1110.jpg 1_0110_1111.jpg 1_0111_1110.jpg 1_0111_1111.jpg  -geometry 128x128 1_011_111.jpg
magick.exe montage 1_1000_0000.jpg 1_1000_0001.jpg 1_1001_0000.jpg 1_1001_0001.jpg  -geometry 128x128 1_100_000.jpg
magick.exe montage 1_1000_0010.jpg 1_1000_0011.jpg 1_1001_0010.jpg 1_1001_0011.jpg  -geometry 128x128 1_100_001.jpg
magick.exe montage 1_1000_0100.jpg 1_1000_0101.jpg 1_1001_0100.jpg 1_1001_0101.jpg  -geometry 128x128 1_100_010.jpg
magick.exe montage 1_1000_0110.jpg 1_1000_0111.jpg 1_1001_0110.jpg 1_1001_0111.jpg  -geometry 128x128 1_100_011.jpg
magick.exe montage 1_1000_1000.jpg 1_1000_1001.jpg 1_1001_1000.jpg 1_1001_1001.jpg  -geometry 128x128 1_100_100.jpg
magick.exe montage 1_1000_1010.jpg 1_1000_1011.jpg 1_1001_1010.jpg 1_1001_1011.jpg  -geometry 128x128 1_100_101.jpg
magick.exe montage 1_1000_1100.jpg 1_1000_1101.jpg 1_1001_1100.jpg 1_1001_1101.jpg  -geometry 128x128 1_100_110.jpg
magick.exe montage 1_1000_1110.jpg 1_1000_1111.jpg 1_1001_1110.jpg 1_1001_1111.jpg  -geometry 128x128 1_100_111.jpg
magick.exe montage 1_1010_0000.jpg 1_1010_0001.jpg 1_1011_0000.jpg 1_1011_0001.jpg  -geometry 128x128 1_101_000.jpg
magick.exe montage 1_1010_0010.jpg 1_1010_0011.jpg 1_1011_0010.jpg 1_1011_0011.jpg  -geometry 128x128 1_101_001.jpg
magick.exe montage 1_1010_0100.jpg 1_1010_0101.jpg 1_1011_0100.jpg 1_1011_0101.jpg  -geometry 128x128 1_101_010.jpg
magick.exe montage 1_1010_0110.jpg 1_1010_0111.jpg 1_1011_0110.jpg 1_1011_0111.jpg  -geometry 128x128 1_101_011.jpg
magick.exe montage 1_1010_1000.jpg 1_1010_1001.jpg 1_1011_1000.jpg 1_1011_1001.jpg  -geometry 128x128 1_101_100.jpg
magick.exe montage 1_1010_1010.jpg 1_1010_1011.jpg 1_1011_1010.jpg 1_1011_1011.jpg  -geometry 128x128 1_101_101.jpg
magick.exe montage 1_1010_1100.jpg 1_1010_1101.jpg 1_1011_1100.jpg 1_1011_1101.jpg  -geometry 128x128 1_101_110.jpg
magick.exe montage 1_1010_1110.jpg 1_1010_1111.jpg 1_1011_1110.jpg 1_1011_1111.jpg  -geometry 128x128 1_101_111.jpg
magick.exe montage 1_1100_0000.jpg 1_1100_0001.jpg 1_1101_0000.jpg 1_1101_0001.jpg  -geometry 128x128 1_110_000.jpg
magick.exe montage 1_1100_0010.jpg 1_1100_0011.jpg 1_1101_0010.jpg 1_1101_0011.jpg  -geometry 128x128 1_110_001.jpg
magick.exe montage 1_1100_0100.jpg 1_1100_0101.jpg 1_1101_0100.jpg 1_1101_0101.jpg  -geometry 128x128 1_110_010.jpg
magick.exe montage 1_1100_0110.jpg 1_1100_0111.jpg 1_1101_0110.jpg 1_1101_0111.jpg  -geometry 128x128 1_110_011.jpg
magick.exe montage 1_1100_1000.jpg 1_1100_1001.jpg 1_1101_1000.jpg 1_1101_1001.jpg  -geometry 128x128 1_110_100.jpg
magick.exe montage 1_1100_1010.jpg 1_1100_1011.jpg 1_1101_1010.jpg 1_1101_1011.jpg  -geometry 128x128 1_110_101.jpg
magick.exe montage 1_1100_1100.jpg 1_1100_1101.jpg 1_1101_1100.jpg 1_1101_1101.jpg  -geometry 128x128 1_110_110.jpg
magick.exe montage 1_1100_1110.jpg 1_1100_1111.jpg 1_1101_1110.jpg 1_1101_1111.jpg  -geometry 128x128 1_110_111.jpg
magick.exe montage 1_1110_0000.jpg 1_1110_0001.jpg 1_1111_0000.jpg 1_1111_0001.jpg  -geometry 128x128 1_111_000.jpg
magick.exe montage 1_1110_0010.jpg 1_1110_0011.jpg 1_1111_0010.jpg 1_1111_0011.jpg  -geometry 128x128 1_111_001.jpg
magick.exe montage 1_1110_0100.jpg 1_1110_0101.jpg 1_1111_0100.jpg 1_1111_0101.jpg  -geometry 128x128 1_111_010.jpg
magick.exe montage 1_1110_0110.jpg 1_1110_0111.jpg 1_1111_0110.jpg 1_1111_0111.jpg  -geometry 128x128 1_111_011.jpg
magick.exe montage 1_1110_1000.jpg 1_1110_1001.jpg 1_1111_1000.jpg 1_1111_1001.jpg  -geometry 128x128 1_111_100.jpg
magick.exe montage 1_1110_1010.jpg 1_1110_1011.jpg 1_1111_1010.jpg 1_1111_1011.jpg  -geometry 128x128 1_111_101.jpg
magick.exe montage 1_1110_1100.jpg 1_1110_1101.jpg 1_1111_1100.jpg 1_1111_1101.jpg  -geometry 128x128 1_111_110.jpg
magick.exe montage 1_1110_1110.jpg 1_1110_1111.jpg 1_1111_1110.jpg 1_1111_1111.jpg  -geometry 128x128 1_111_111.jpg
magick.exe montage 2_0000_0000.jpg 2_0000_0001.jpg 2_0000_0010.jpg 2_0000_0011.jpg 2_0001_0000.jpg 2_0001_0001.jpg 2_0001_0010.jpg 2_0001_0011.jpg 2_0010_0000.jpg 2_0010_0001.jpg 2_0010_0010.jpg 2_0010_0011.jpg 2_0011_0000.jpg 2_0011_0001.jpg 2_0011_0010.jpg 2_0011_0011.jpg  -geometry 64x64 2_00_00.jpg
magick.exe montage 2_0000_0100.jpg 2_0000_0101.jpg 2_0000_0110.jpg 2_0000_0111.jpg 2_0001_0100.jpg 2_0001_0101.jpg 2_0001_0110.jpg 2_0001_0111.jpg 2_0010_0100.jpg 2_0010_0101.jpg 2_0010_0110.jpg 2_0010_0111.jpg 2_0011_0100.jpg 2_0011_0101.jpg 2_0011_0110.jpg 2_0011_0111.jpg  -geometry 64x64 2_00_01.jpg
magick.exe montage 2_0000_1000.jpg 2_0000_1001.jpg 2_0000_1010.jpg 2_0000_1011.jpg 2_0001_1000.jpg 2_0001_1001.jpg 2_0001_1010.jpg 2_0001_1011.jpg 2_0010_1000.jpg 2_0010_1001.jpg 2_0010_1010.jpg 2_0010_1011.jpg 2_0011_1000.jpg 2_0011_1001.jpg 2_0011_1010.jpg 2_0011_1011.jpg  -geometry 64x64 2_00_10.jpg
magick.exe montage 2_0000_1100.jpg 2_0000_1101.jpg 2_0000_1110.jpg 2_0000_1111.jpg 2_0001_1100.jpg 2_0001_1101.jpg 2_0001_1110.jpg 2_0001_1111.jpg 2_0010_1100.jpg 2_0010_1101.jpg 2_0010_1110.jpg 2_0010_1111.jpg 2_0011_1100.jpg 2_0011_1101.jpg 2_0011_1110.jpg 2_0011_1111.jpg  -geometry 64x64 2_00_11.jpg
magick.exe montage 2_0100_0000.jpg 2_0100_0001.jpg 2_0100_0010.jpg 2_0100_0011.jpg 2_0101_0000.jpg 2_0101_0001.jpg 2_0101_0010.jpg 2_0101_0011.jpg 2_0110_0000.jpg 2_0110_0001.jpg 2_0110_0010.jpg 2_0110_0011.jpg 2_0111_0000.jpg 2_0111_0001.jpg 2_0111_0010.jpg 2_0111_0011.jpg  -geometry 64x64 2_01_00.jpg
magick.exe montage 2_0100_0100.jpg 2_0100_0101.jpg 2_0100_0110.jpg 2_0100_0111.jpg 2_0101_0100.jpg 2_0101_0101.jpg 2_0101_0110.jpg 2_0101_0111.jpg 2_0110_0100.jpg 2_0110_0101.jpg 2_0110_0110.jpg 2_0110_0111.jpg 2_0111_0100.jpg 2_0111_0101.jpg 2_0111_0110.jpg 2_0111_0111.jpg  -geometry 64x64 2_01_01.jpg
magick.exe montage 2_0100_1000.jpg 2_0100_1001.jpg 2_0100_1010.jpg 2_0100_1011.jpg 2_0101_1000.jpg 2_0101_1001.jpg 2_0101_1010.jpg 2_0101_1011.jpg 2_0110_1000.jpg 2_0110_1001.jpg 2_0110_1010.jpg 2_0110_1011.jpg 2_0111_1000.jpg 2_0111_1001.jpg 2_0111_1010.jpg 2_0111_1011.jpg  -geometry 64x64 2_01_10.jpg
magick.exe montage 2_0100_1100.jpg 2_0100_1101.jpg 2_0100_1110.jpg 2_0100_1111.jpg 2_0101_1100.jpg 2_0101_1101.jpg 2_0101_1110.jpg 2_0101_1111.jpg 2_0110_1100.jpg 2_0110_1101.jpg 2_0110_1110.jpg 2_0110_1111.jpg 2_0111_1100.jpg 2_0111_1101.jpg 2_0111_1110.jpg 2_0111_1111.jpg  -geometry 64x64 2_01_11.jpg
magick.exe montage 2_1000_0000.jpg 2_1000_0001.jpg 2_1000_0010.jpg 2_1000_0011.jpg 2_1001_0000.jpg 2_1001_0001.jpg 2_1001_0010.jpg 2_1001_0011.jpg 2_1010_0000.jpg 2_1010_0001.jpg 2_1010_0010.jpg 2_1010_0011.jpg 2_1011_0000.jpg 2_1011_0001.jpg 2_1011_0010.jpg 2_1011_0011.jpg  -geometry 64x64 2_10_00.jpg
magick.exe montage 2_1000_0100.jpg 2_1000_0101.jpg 2_1000_0110.jpg 2_1000_0111.jpg 2_1001_0100.jpg 2_1001_0101.jpg 2_1001_0110.jpg 2_1001_0111.jpg 2_1010_0100.jpg 2_1010_0101.jpg 2_1010_0110.jpg 2_1010_0111.jpg 2_1011_0100.jpg 2_1011_0101.jpg 2_1011_0110.jpg 2_1011_0111.jpg  -geometry 64x64 2_10_01.jpg
magick.exe montage 2_1000_1000.jpg 2_1000_1001.jpg 2_1000_1010.jpg 2_1000_1011.jpg 2_1001_1000.jpg 2_1001_1001.jpg 2_1001_1010.jpg 2_1001_1011.jpg 2_1010_1000.jpg 2_1010_1001.jpg 2_1010_1010.jpg 2_1010_1011.jpg 2_1011_1000.jpg 2_1011_1001.jpg 2_1011_1010.jpg 2_1011_1011.jpg  -geometry 64x64 2_10_10.jpg
magick.exe montage 2_1000_1100.jpg 2_1000_1101.jpg 2_1000_1110.jpg 2_1000_1111.jpg 2_1001_1100.jpg 2_1001_1101.jpg 2_1001_1110.jpg 2_1001_1111.jpg 2_1010_1100.jpg 2_1010_1101.jpg 2_1010_1110.jpg 2_1010_1111.jpg 2_1011_1100.jpg 2_1011_1101.jpg 2_1011_1110.jpg 2_1011_1111.jpg  -geometry 64x64 2_10_11.jpg
magick.exe montage 2_1100_0000.jpg 2_1100_0001.jpg 2_1100_0010.jpg 2_1100_0011.jpg 2_1101_0000.jpg 2_1101_0001.jpg 2_1101_0010.jpg 2_1101_0011.jpg 2_1110_0000.jpg 2_1110_0001.jpg 2_1110_0010.jpg 2_1110_0011.jpg 2_1111_0000.jpg 2_1111_0001.jpg 2_1111_0010.jpg 2_1111_0011.jpg  -geometry 64x64 2_11_00.jpg
magick.exe montage 2_1100_0100.jpg 2_1100_0101.jpg 2_1100_0110.jpg 2_1100_0111.jpg 2_1101_0100.jpg 2_1101_0101.jpg 2_1101_0110.jpg 2_1101_0111.jpg 2_1110_0100.jpg 2_1110_0101.jpg 2_1110_0110.jpg 2_1110_0111.jpg 2_1111_0100.jpg 2_1111_0101.jpg 2_1111_0110.jpg 2_1111_0111.jpg  -geometry 64x64 2_11_01.jpg
magick.exe montage 2_1100_1000.jpg 2_1100_1001.jpg 2_1100_1010.jpg 2_1100_1011.jpg 2_1101_1000.jpg 2_1101_1001.jpg 2_1101_1010.jpg 2_1101_1011.jpg 2_1110_1000.jpg 2_1110_1001.jpg 2_1110_1010.jpg 2_1110_1011.jpg 2_1111_1000.jpg 2_1111_1001.jpg 2_1111_1010.jpg 2_1111_1011.jpg  -geometry 64x64 2_11_10.jpg
magick.exe montage 2_1100_1100.jpg 2_1100_1101.jpg 2_1100_1110.jpg 2_1100_1111.jpg 2_1101_1100.jpg 2_1101_1101.jpg 2_1101_1110.jpg 2_1101_1111.jpg 2_1110_1100.jpg 2_1110_1101.jpg 2_1110_1110.jpg 2_1110_1111.jpg 2_1111_1100.jpg 2_1111_1101.jpg 2_1111_1110.jpg 2_1111_1111.jpg  -geometry 64x64 2_11_11.jpg
magick.exe montage 3_0000_0000.jpg 3_0000_0001.jpg 3_0000_0010.jpg 3_0000_0011.jpg 3_0000_0100.jpg 3_0000_0101.jpg 3_0000_0110.jpg 3_0000_0111.jpg 3_0001_0000.jpg 3_0001_0001.jpg 3_0001_0010.jpg 3_0001_0011.jpg 3_0001_0100.jpg 3_0001_0101.jpg 3_0001_0110.jpg 3_0001_0111.jpg 3_0010_0000.jpg 3_0010_0001.jpg 3_0010_0010.jpg 3_0010_0011.jpg 3_0010_0100.jpg 3_0010_0101.jpg 3_0010_0110.jpg 3_0010_0111.jpg 3_0011_0000.jpg 3_0011_0001.jpg 3_0011_0010.jpg 3_0011_0011.jpg 3_0011_0100.jpg 3_0011_0101.jpg 3_0011_0110.jpg 3_0011_0111.jpg 3_0100_0000.jpg 3_0100_0001.jpg 3_0100_0010.jpg 3_0100_0011.jpg 3_0100_0100.jpg 3_0100_0101.jpg 3_0100_0110.jpg 3_0100_0111.jpg 3_0101_0000.jpg 3_0101_0001.jpg 3_0101_0010.jpg 3_0101_0011.jpg 3_0101_0100.jpg 3_0101_0101.jpg 3_0101_0110.jpg 3_0101_0111.jpg 3_0110_0000.jpg 3_0110_0001.jpg 3_0110_0010.jpg 3_0110_0011.jpg 3_0110_0100.jpg 3_0110_0101.jpg 3_0110_0110.jpg 3_0110_0111.jpg 3_0111_0000.jpg 3_0111_0001.jpg 3_0111_0010.jpg 3_0111_0011.jpg 3_0111_0100.jpg 3_0111_0101.jpg 3_0111_0110.jpg 3_0111_0111.jpg  -geometry 32x32 3_0_0.jpg
magick.exe montage 3_0000_1000.jpg 3_0000_1001.jpg 3_0000_1010.jpg 3_0000_1011.jpg 3_0000_1100.jpg 3_0000_1101.jpg 3_0000_1110.jpg 3_0000_1111.jpg 3_0001_1000.jpg 3_0001_1001.jpg 3_0001_1010.jpg 3_0001_1011.jpg 3_0001_1100.jpg 3_0001_1101.jpg 3_0001_1110.jpg 3_0001_1111.jpg 3_0010_1000.jpg 3_0010_1001.jpg 3_0010_1010.jpg 3_0010_1011.jpg 3_0010_1100.jpg 3_0010_1101.jpg 3_0010_1110.jpg 3_0010_1111.jpg 3_0011_1000.jpg 3_0011_1001.jpg 3_0011_1010.jpg 3_0011_1011.jpg 3_0011_1100.jpg 3_0011_1101.jpg 3_0011_1110.jpg 3_0011_1111.jpg 3_0100_1000.jpg 3_0100_1001.jpg 3_0100_1010.jpg 3_0100_1011.jpg 3_0100_1100.jpg 3_0100_1101.jpg 3_0100_1110.jpg 3_0100_1111.jpg 3_0101_1000.jpg 3_0101_1001.jpg 3_0101_1010.jpg 3_0101_1011.jpg 3_0101_1100.jpg 3_0101_1101.jpg 3_0101_1110.jpg 3_0101_1111.jpg 3_0110_1000.jpg 3_0110_1001.jpg 3_0110_1010.jpg 3_0110_1011.jpg 3_0110_1100.jpg 3_0110_1101.jpg 3_0110_1110.jpg 3_0110_1111.jpg 3_0111_1000.jpg 3_0111_1001.jpg 3_0111_1010.jpg 3_0111_1011.jpg 3_0111_1100.jpg 3_0111_1101.jpg 3_0111_1110.jpg 3_0111_1111.jpg  -geometry 32x32 3_0_1.jpg
magick.exe montage 3_1000_0000.jpg 3_1000_0001.jpg 3_1000_0010.jpg 3_1000_0011.jpg 3_1000_0100.jpg 3_1000_0101.jpg 3_1000_0110.jpg 3_1000_0111.jpg 3_1001_0000.jpg 3_1001_0001.jpg 3_1001_0010.jpg 3_1001_0011.jpg 3_1001_0100.jpg 3_1001_0101.jpg 3_1001_0110.jpg 3_1001_0111.jpg 3_1010_0000.jpg 3_1010_0001.jpg 3_1010_0010.jpg 3_1010_0011.jpg 3_1010_0100.jpg 3_1010_0101.jpg 3_1010_0110.jpg 3_1010_0111.jpg 3_1011_0000.jpg 3_1011_0001.jpg 3_1011_0010.jpg 3_1011_0011.jpg 3_1011_0100.jpg 3_1011_0101.jpg 3_1011_0110.jpg 3_1011_0111.jpg 3_1100_0000.jpg 3_1100_0001.jpg 3_1100_0010.jpg 3_1100_0011.jpg 3_1100_0100.jpg 3_1100_0101.jpg 3_1100_0110.jpg 3_1100_0111.jpg 3_1101_0000.jpg 3_1101_0001.jpg 3_1101_0010.jpg 3_1101_0011.jpg 3_1101_0100.jpg 3_1101_0101.jpg 3_1101_0110.jpg 3_1101_0111.jpg 3_1110_0000.jpg 3_1110_0001.jpg 3_1110_0010.jpg 3_1110_0011.jpg 3_1110_0100.jpg 3_1110_0101.jpg 3_1110_0110.jpg 3_1110_0111.jpg 3_1111_0000.jpg 3_1111_0001.jpg 3_1111_0010.jpg 3_1111_0011.jpg 3_1111_0100.jpg 3_1111_0101.jpg 3_1111_0110.jpg 3_1111_0111.jpg  -geometry 32x32 3_1_0.jpg
magick.exe montage 3_1000_1000.jpg 3_1000_1001.jpg 3_1000_1010.jpg 3_1000_1011.jpg 3_1000_1100.jpg 3_1000_1101.jpg 3_1000_1110.jpg 3_1000_1111.jpg 3_1001_1000.jpg 3_1001_1001.jpg 3_1001_1010.jpg 3_1001_1011.jpg 3_1001_1100.jpg 3_1001_1101.jpg 3_1001_1110.jpg 3_1001_1111.jpg 3_1010_1000.jpg 3_1010_1001.jpg 3_1010_1010.jpg 3_1010_1011.jpg 3_1010_1100.jpg 3_1010_1101.jpg 3_1010_1110.jpg 3_1010_1111.jpg 3_1011_1000.jpg 3_1011_1001.jpg 3_1011_1010.jpg 3_1011_1011.jpg 3_1011_1100.jpg 3_1011_1101.jpg 3_1011_1110.jpg 3_1011_1111.jpg 3_1100_1000.jpg 3_1100_1001.jpg 3_1100_1010.jpg 3_1100_1011.jpg 3_1100_1100.jpg 3_1100_1101.jpg 3_1100_1110.jpg 3_1100_1111.jpg 3_1101_1000.jpg 3_1101_1001.jpg 3_1101_1010.jpg 3_1101_1011.jpg 3_1101_1100.jpg 3_1101_1101.jpg 3_1101_1110.jpg 3_1101_1111.jpg 3_1110_1000.jpg 3_1110_1001.jpg 3_1110_1010.jpg 3_1110_1011.jpg 3_1110_1100.jpg 3_1110_1101.jpg 3_1110_1110.jpg 3_1110_1111.jpg 3_1111_1000.jpg 3_1111_1001.jpg 3_1111_1010.jpg 3_1111_1011.jpg 3_1111_1100.jpg 3_1111_1101.jpg 3_1111_1110.jpg 3_1111_1111.jpg  -geometry 32x32 3_1_1.jpg
magick.exe montage 4_0000_0000.jpg 4_0000_0001.jpg 4_0000_0010.jpg 4_0000_0011.jpg 4_0000_0100.jpg 4_0000_0101.jpg 4_0000_0110.jpg 4_0000_0111.jpg 4_0000_1000.jpg 4_0000_1001.jpg 4_0000_1010.jpg 4_0000_1011.jpg 4_0000_1100.jpg 4_0000_1101.jpg 4_0000_1110.jpg 4_0000_1111.jpg 4_0001_0000.jpg 4_0001_0001.jpg 4_0001_0010.jpg 4_0001_0011.jpg 4_0001_0100.jpg 4_0001_0101.jpg 4_0001_0110.jpg 4_0001_0111.jpg 4_0001_1000.jpg 4_0001_1001.jpg 4_0001_1010.jpg 4_0001_1011.jpg 4_0001_1100.jpg 4_0001_1101.jpg 4_0001_1110.jpg 4_0001_1111.jpg 4_0010_0000.jpg 4_0010_0001.jpg 4_0010_0010.jpg 4_0010_0011.jpg 4_0010_0100.jpg 4_0010_0101.jpg 4_0010_0110.jpg 4_0010_0111.jpg 4_0010_1000.jpg 4_0010_1001.jpg 4_0010_1010.jpg 4_0010_1011.jpg 4_0010_1100.jpg 4_0010_1101.jpg 4_0010_1110.jpg 4_0010_1111.jpg 4_0011_0000.jpg 4_0011_0001.jpg 4_0011_0010.jpg 4_0011_0011.jpg 4_0011_0100.jpg 4_0011_0101.jpg 4_0011_0110.jpg 4_0011_0111.jpg 4_0011_1000.jpg 4_0011_1001.jpg 4_0011_1010.jpg 4_0011_1011.jpg 4_0011_1100.jpg 4_0011_1101.jpg 4_0011_1110.jpg 4_0011_1111.jpg 4_0100_0000.jpg 4_0100_0001.jpg 4_0100_0010.jpg 4_0100_0011.jpg 4_0100_0100.jpg 4_0100_0101.jpg 4_0100_0110.jpg 4_0100_0111.jpg 4_0100_1000.jpg 4_0100_1001.jpg 4_0100_1010.jpg 4_0100_1011.jpg 4_0100_1100.jpg 4_0100_1101.jpg 4_0100_1110.jpg 4_0100_1111.jpg 4_0101_0000.jpg 4_0101_0001.jpg 4_0101_0010.jpg 4_0101_0011.jpg 4_0101_0100.jpg 4_0101_0101.jpg 4_0101_0110.jpg 4_0101_0111.jpg 4_0101_1000.jpg 4_0101_1001.jpg 4_0101_1010.jpg 4_0101_1011.jpg 4_0101_1100.jpg 4_0101_1101.jpg 4_0101_1110.jpg 4_0101_1111.jpg 4_0110_0000.jpg 4_0110_0001.jpg 4_0110_0010.jpg 4_0110_0011.jpg 4_0110_0100.jpg 4_0110_0101.jpg 4_0110_0110.jpg 4_0110_0111.jpg 4_0110_1000.jpg 4_0110_1001.jpg 4_0110_1010.jpg 4_0110_1011.jpg 4_0110_1100.jpg 4_0110_1101.jpg 4_0110_1110.jpg 4_0110_1111.jpg 4_0111_0000.jpg 4_0111_0001.jpg 4_0111_0010.jpg 4_0111_0011.jpg 4_0111_0100.jpg 4_0111_0101.jpg 4_0111_0110.jpg 4_0111_0111.jpg 4_0111_1000.jpg 4_0111_1001.jpg 4_0111_1010.jpg 4_0111_1011.jpg 4_0111_1100.jpg 4_0111_1101.jpg 4_0111_1110.jpg 4_0111_1111.jpg 4_1000_0000.jpg 4_1000_0001.jpg 4_1000_0010.jpg 4_1000_0011.jpg 4_1000_0100.jpg 4_1000_0101.jpg 4_1000_0110.jpg 4_1000_0111.jpg 4_1000_1000.jpg 4_1000_1001.jpg 4_1000_1010.jpg 4_1000_1011.jpg 4_1000_1100.jpg 4_1000_1101.jpg 4_1000_1110.jpg 4_1000_1111.jpg 4_1001_0000.jpg 4_1001_0001.jpg 4_1001_0010.jpg 4_1001_0011.jpg 4_1001_0100.jpg 4_1001_0101.jpg 4_1001_0110.jpg 4_1001_0111.jpg 4_1001_1000.jpg 4_1001_1001.jpg 4_1001_1010.jpg 4_1001_1011.jpg 4_1001_1100.jpg 4_1001_1101.jpg 4_1001_1110.jpg 4_1001_1111.jpg 4_1010_0000.jpg 4_1010_0001.jpg 4_1010_0010.jpg 4_1010_0011.jpg 4_1010_0100.jpg 4_1010_0101.jpg 4_1010_0110.jpg 4_1010_0111.jpg 4_1010_1000.jpg 4_1010_1001.jpg 4_1010_1010.jpg 4_1010_1011.jpg 4_1010_1100.jpg 4_1010_1101.jpg 4_1010_1110.jpg 4_1010_1111.jpg 4_1011_0000.jpg 4_1011_0001.jpg 4_1011_0010.jpg 4_1011_0011.jpg 4_1011_0100.jpg 4_1011_0101.jpg 4_1011_0110.jpg 4_1011_0111.jpg 4_1011_1000.jpg 4_1011_1001.jpg 4_1011_1010.jpg 4_1011_1011.jpg 4_1011_1100.jpg 4_1011_1101.jpg 4_1011_1110.jpg 4_1011_1111.jpg 4_1100_0000.jpg 4_1100_0001.jpg 4_1100_0010.jpg 4_1100_0011.jpg 4_1100_0100.jpg 4_1100_0101.jpg 4_1100_0110.jpg 4_1100_0111.jpg 4_1100_1000.jpg 4_1100_1001.jpg 4_1100_1010.jpg 4_1100_1011.jpg 4_1100_1100.jpg 4_1100_1101.jpg 4_1100_1110.jpg 4_1100_1111.jpg 4_1101_0000.jpg 4_1101_0001.jpg 4_1101_0010.jpg 4_1101_0011.jpg 4_1101_0100.jpg 4_1101_0101.jpg 4_1101_0110.jpg 4_1101_0111.jpg 4_1101_1000.jpg 4_1101_1001.jpg 4_1101_1010.jpg 4_1101_1011.jpg 4_1101_1100.jpg 4_1101_1101.jpg 4_1101_1110.jpg 4_1101_1111.jpg 4_1110_0000.jpg 4_1110_0001.jpg 4_1110_0010.jpg 4_1110_0011.jpg 4_1110_0100.jpg 4_1110_0101.jpg 4_1110_0110.jpg 4_1110_0111.jpg 4_1110_1000.jpg 4_1110_1001.jpg 4_1110_1010.jpg 4_1110_1011.jpg 4_1110_1100.jpg 4_1110_1101.jpg 4_1110_1110.jpg 4_1110_1111.jpg 4_1111_0000.jpg 4_1111_0001.jpg 4_1111_0010.jpg 4_1111_0011.jpg 4_1111_0100.jpg 4_1111_0101.jpg 4_1111_0110.jpg 4_1111_0111.jpg 4_1111_1000.jpg 4_1111_1001.jpg 4_1111_1010.jpg 4_1111_1011.jpg 4_1111_1100.jpg 4_1111_1101.jpg 4_1111_1110.jpg 4_1111_1111.jpg  -geometry 16x16 4.jpg
del 1_0000_0000.jpg
del 1_0000_0001.jpg
del 1_0000_0010.jpg
del 1_0000_0011.jpg
del 1_0000_0100.jpg
del 1_0000_0101.jpg
del 1_0000_0110.jpg
del 1_0000_0111.jpg
del 1_0000_1000.jpg
del 1_0000_1001.jpg
del 1_0000_1010.jpg
del 1_0000_1011.jpg
del 1_0000_1100.jpg
del 1_0000_1101.jpg
del 1_0000_1110.jpg
del 1_0000_1111.jpg
del 1_0001_0000.jpg
del 1_0001_0001.jpg
del 1_0001_0010.jpg
del 1_0001_0011.jpg
del 1_0001_0100.jpg
del 1_0001_0101.jpg
del 1_0001_0110.jpg
del 1_0001_0111.jpg
del 1_0001_1000.jpg
del 1_0001_1001.jpg
del 1_0001_1010.jpg
del 1_0001_1011.jpg
del 1_0001_1100.jpg
del 1_0001_1101.jpg
del 1_0001_1110.jpg
del 1_0001_1111.jpg
del 1_0010_0000.jpg
del 1_0010_0001.jpg
del 1_0010_0010.jpg
del 1_0010_0011.jpg
del 1_0010_0100.jpg
del 1_0010_0101.jpg
del 1_0010_0110.jpg
del 1_0010_0111.jpg
del 1_0010_1000.jpg
del 1_0010_1001.jpg
del 1_0010_1010.jpg
del 1_0010_1011.jpg
del 1_0010_1100.jpg
del 1_0010_1101.jpg
del 1_0010_1110.jpg
del 1_0010_1111.jpg
del 1_0011_0000.jpg
del 1_0011_0001.jpg
del 1_0011_0010.jpg
del 1_0011_0011.jpg
del 1_0011_0100.jpg
del 1_0011_0101.jpg
del 1_0011_0110.jpg
del 1_0011_0111.jpg
del 1_0011_1000.jpg
del 1_0011_1001.jpg
del 1_0011_1010.jpg
del 1_0011_1011.jpg
del 1_0011_1100.jpg
del 1_0011_1101.jpg
del 1_0011_1110.jpg
del 1_0011_1111.jpg
del 1_0100_0000.jpg
del 1_0100_0001.jpg
del 1_0100_0010.jpg
del 1_0100_0011.jpg
del 1_0100_0100.jpg
del 1_0100_0101.jpg
del 1_0100_0110.jpg
del 1_0100_0111.jpg
del 1_0100_1000.jpg
del 1_0100_1001.jpg
del 1_0100_1010.jpg
del 1_0100_1011.jpg
del 1_0100_1100.jpg
del 1_0100_1101.jpg
del 1_0100_1110.jpg
del 1_0100_1111.jpg
del 1_0101_0000.jpg
del 1_0101_0001.jpg
del 1_0101_0010.jpg
del 1_0101_0011.jpg
del 1_0101_0100.jpg
del 1_0101_0101.jpg
del 1_0101_0110.jpg
del 1_0101_0111.jpg
del 1_0101_1000.jpg
del 1_0101_1001.jpg
del 1_0101_1010.jpg
del 1_0101_1011.jpg
del 1_0101_1100.jpg
del 1_0101_1101.jpg
del 1_0101_1110.jpg
del 1_0101_1111.jpg
del 1_0110_0000.jpg
del 1_0110_0001.jpg
del 1_0110_0010.jpg
del 1_0110_0011.jpg
del 1_0110_0100.jpg
del 1_0110_0101.jpg
del 1_0110_0110.jpg
del 1_0110_0111.jpg
del 1_0110_1000.jpg
del 1_0110_1001.jpg
del 1_0110_1010.jpg
del 1_0110_1011.jpg
del 1_0110_1100.jpg
del 1_0110_1101.jpg
del 1_0110_1110.jpg
del 1_0110_1111.jpg
del 1_0111_0000.jpg
del 1_0111_0001.jpg
del 1_0111_0010.jpg
del 1_0111_0011.jpg
del 1_0111_0100.jpg
del 1_0111_0101.jpg
del 1_0111_0110.jpg
del 1_0111_0111.jpg
del 1_0111_1000.jpg
del 1_0111_1001.jpg
del 1_0111_1010.jpg
del 1_0111_1011.jpg
del 1_0111_1100.jpg
del 1_0111_1101.jpg
del 1_0111_1110.jpg
del 1_0111_1111.jpg
del 1_1000_0000.jpg
del 1_1000_0001.jpg
del 1_1000_0010.jpg
del 1_1000_0011.jpg
del 1_1000_0100.jpg
del 1_1000_0101.jpg
del 1_1000_0110.jpg
del 1_1000_0111.jpg
del 1_1000_1000.jpg
del 1_1000_1001.jpg
del 1_1000_1010.jpg
del 1_1000_1011.jpg
del 1_1000_1100.jpg
del 1_1000_1101.jpg
del 1_1000_1110.jpg
del 1_1000_1111.jpg
del 1_1001_0000.jpg
del 1_1001_0001.jpg
del 1_1001_0010.jpg
del 1_1001_0011.jpg
del 1_1001_0100.jpg
del 1_1001_0101.jpg
del 1_1001_0110.jpg
del 1_1001_0111.jpg
del 1_1001_1000.jpg
del 1_1001_1001.jpg
del 1_1001_1010.jpg
del 1_1001_1011.jpg
del 1_1001_1100.jpg
del 1_1001_1101.jpg
del 1_1001_1110.jpg
del 1_1001_1111.jpg
del 1_1010_0000.jpg
del 1_1010_0001.jpg
del 1_1010_0010.jpg
del 1_1010_0011.jpg
del 1_1010_0100.jpg
del 1_1010_0101.jpg
del 1_1010_0110.jpg
del 1_1010_0111.jpg
del 1_1010_1000.jpg
del 1_1010_1001.jpg
del 1_1010_1010.jpg
del 1_1010_1011.jpg
del 1_1010_1100.jpg
del 1_1010_1101.jpg
del 1_1010_1110.jpg
del 1_1010_1111.jpg
del 1_1011_0000.jpg
del 1_1011_0001.jpg
del 1_1011_0010.jpg
del 1_1011_0011.jpg
del 1_1011_0100.jpg
del 1_1011_0101.jpg
del 1_1011_0110.jpg
del 1_1011_0111.jpg
del 1_1011_1000.jpg
del 1_1011_1001.jpg
del 1_1011_1010.jpg
del 1_1011_1011.jpg
del 1_1011_1100.jpg
del 1_1011_1101.jpg
del 1_1011_1110.jpg
del 1_1011_1111.jpg
del 1_1100_0000.jpg
del 1_1100_0001.jpg
del 1_1100_0010.jpg
del 1_1100_0011.jpg
del 1_1100_0100.jpg
del 1_1100_0101.jpg
del 1_1100_0110.jpg
del 1_1100_0111.jpg
del 1_1100_1000.jpg
del 1_1100_1001.jpg
del 1_1100_1010.jpg
del 1_1100_1011.jpg
del 1_1100_1100.jpg
del 1_1100_1101.jpg
del 1_1100_1110.jpg
del 1_1100_1111.jpg
del 1_1101_0000.jpg
del 1_1101_0001.jpg
del 1_1101_0010.jpg
del 1_1101_0011.jpg
del 1_1101_0100.jpg
del 1_1101_0101.jpg
del 1_1101_0110.jpg
del 1_1101_0111.jpg
del 1_1101_1000.jpg
del 1_1101_1001.jpg
del 1_1101_1010.jpg
del 1_1101_1011.jpg
del 1_1101_1100.jpg
del 1_1101_1101.jpg
del 1_1101_1110.jpg
del 1_1101_1111.jpg
del 1_1110_0000.jpg
del 1_1110_0001.jpg
del 1_1110_0010.jpg
del 1_1110_0011.jpg
del 1_1110_0100.jpg
del 1_1110_0101.jpg
del 1_1110_0110.jpg
del 1_1110_0111.jpg
del 1_1110_1000.jpg
del 1_1110_1001.jpg
del 1_1110_1010.jpg
del 1_1110_1011.jpg
del 1_1110_1100.jpg
del 1_1110_1101.jpg
del 1_1110_1110.jpg
del 1_1110_1111.jpg
del 1_1111_0000.jpg
del 1_1111_0001.jpg
del 1_1111_0010.jpg
del 1_1111_0011.jpg
del 1_1111_0100.jpg
del 1_1111_0101.jpg
del 1_1111_0110.jpg
del 1_1111_0111.jpg
del 1_1111_1000.jpg
del 1_1111_1001.jpg
del 1_1111_1010.jpg
del 1_1111_1011.jpg
del 1_1111_1100.jpg
del 1_1111_1101.jpg
del 1_1111_1110.jpg
del 1_1111_1111.jpg
del 2_0000_0000.jpg
del 2_0000_0001.jpg
del 2_0000_0010.jpg
del 2_0000_0011.jpg
del 2_0000_0100.jpg
del 2_0000_0101.jpg
del 2_0000_0110.jpg
del 2_0000_0111.jpg
del 2_0000_1000.jpg
del 2_0000_1001.jpg
del 2_0000_1010.jpg
del 2_0000_1011.jpg
del 2_0000_1100.jpg
del 2_0000_1101.jpg
del 2_0000_1110.jpg
del 2_0000_1111.jpg
del 2_0001_0000.jpg
del 2_0001_0001.jpg
del 2_0001_0010.jpg
del 2_0001_0011.jpg
del 2_0001_0100.jpg
del 2_0001_0101.jpg
del 2_0001_0110.jpg
del 2_0001_0111.jpg
del 2_0001_1000.jpg
del 2_0001_1001.jpg
del 2_0001_1010.jpg
del 2_0001_1011.jpg
del 2_0001_1100.jpg
del 2_0001_1101.jpg
del 2_0001_1110.jpg
del 2_0001_1111.jpg
del 2_0010_0000.jpg
del 2_0010_0001.jpg
del 2_0010_0010.jpg
del 2_0010_0011.jpg
del 2_0010_0100.jpg
del 2_0010_0101.jpg
del 2_0010_0110.jpg
del 2_0010_0111.jpg
del 2_0010_1000.jpg
del 2_0010_1001.jpg
del 2_0010_1010.jpg
del 2_0010_1011.jpg
del 2_0010_1100.jpg
del 2_0010_1101.jpg
del 2_0010_1110.jpg
del 2_0010_1111.jpg
del 2_0011_0000.jpg
del 2_0011_0001.jpg
del 2_0011_0010.jpg
del 2_0011_0011.jpg
del 2_0011_0100.jpg
del 2_0011_0101.jpg
del 2_0011_0110.jpg
del 2_0011_0111.jpg
del 2_0011_1000.jpg
del 2_0011_1001.jpg
del 2_0011_1010.jpg
del 2_0011_1011.jpg
del 2_0011_1100.jpg
del 2_0011_1101.jpg
del 2_0011_1110.jpg
del 2_0011_1111.jpg
del 2_0100_0000.jpg
del 2_0100_0001.jpg
del 2_0100_0010.jpg
del 2_0100_0011.jpg
del 2_0100_0100.jpg
del 2_0100_0101.jpg
del 2_0100_0110.jpg
del 2_0100_0111.jpg
del 2_0100_1000.jpg
del 2_0100_1001.jpg
del 2_0100_1010.jpg
del 2_0100_1011.jpg
del 2_0100_1100.jpg
del 2_0100_1101.jpg
del 2_0100_1110.jpg
del 2_0100_1111.jpg
del 2_0101_0000.jpg
del 2_0101_0001.jpg
del 2_0101_0010.jpg
del 2_0101_0011.jpg
del 2_0101_0100.jpg
del 2_0101_0101.jpg
del 2_0101_0110.jpg
del 2_0101_0111.jpg
del 2_0101_1000.jpg
del 2_0101_1001.jpg
del 2_0101_1010.jpg
del 2_0101_1011.jpg
del 2_0101_1100.jpg
del 2_0101_1101.jpg
del 2_0101_1110.jpg
del 2_0101_1111.jpg
del 2_0110_0000.jpg
del 2_0110_0001.jpg
del 2_0110_0010.jpg
del 2_0110_0011.jpg
del 2_0110_0100.jpg
del 2_0110_0101.jpg
del 2_0110_0110.jpg
del 2_0110_0111.jpg
del 2_0110_1000.jpg
del 2_0110_1001.jpg
del 2_0110_1010.jpg
del 2_0110_1011.jpg
del 2_0110_1100.jpg
del 2_0110_1101.jpg
del 2_0110_1110.jpg
del 2_0110_1111.jpg
del 2_0111_0000.jpg
del 2_0111_0001.jpg
del 2_0111_0010.jpg
del 2_0111_0011.jpg
del 2_0111_0100.jpg
del 2_0111_0101.jpg
del 2_0111_0110.jpg
del 2_0111_0111.jpg
del 2_0111_1000.jpg
del 2_0111_1001.jpg
del 2_0111_1010.jpg
del 2_0111_1011.jpg
del 2_0111_1100.jpg
del 2_0111_1101.jpg
del 2_0111_1110.jpg
del 2_0111_1111.jpg
del 2_1000_0000.jpg
del 2_1000_0001.jpg
del 2_1000_0010.jpg
del 2_1000_0011.jpg
del 2_1000_0100.jpg
del 2_1000_0101.jpg
del 2_1000_0110.jpg
del 2_1000_0111.jpg
del 2_1000_1000.jpg
del 2_1000_1001.jpg
del 2_1000_1010.jpg
del 2_1000_1011.jpg
del 2_1000_1100.jpg
del 2_1000_1101.jpg
del 2_1000_1110.jpg
del 2_1000_1111.jpg
del 2_1001_0000.jpg
del 2_1001_0001.jpg
del 2_1001_0010.jpg
del 2_1001_0011.jpg
del 2_1001_0100.jpg
del 2_1001_0101.jpg
del 2_1001_0110.jpg
del 2_1001_0111.jpg
del 2_1001_1000.jpg
del 2_1001_1001.jpg
del 2_1001_1010.jpg
del 2_1001_1011.jpg
del 2_1001_1100.jpg
del 2_1001_1101.jpg
del 2_1001_1110.jpg
del 2_1001_1111.jpg
del 2_1010_0000.jpg
del 2_1010_0001.jpg
del 2_1010_0010.jpg
del 2_1010_0011.jpg
del 2_1010_0100.jpg
del 2_1010_0101.jpg
del 2_1010_0110.jpg
del 2_1010_0111.jpg
del 2_1010_1000.jpg
del 2_1010_1001.jpg
del 2_1010_1010.jpg
del 2_1010_1011.jpg
del 2_1010_1100.jpg
del 2_1010_1101.jpg
del 2_1010_1110.jpg
del 2_1010_1111.jpg
del 2_1011_0000.jpg
del 2_1011_0001.jpg
del 2_1011_0010.jpg
del 2_1011_0011.jpg
del 2_1011_0100.jpg
del 2_1011_0101.jpg
del 2_1011_0110.jpg
del 2_1011_0111.jpg
del 2_1011_1000.jpg
del 2_1011_1001.jpg
del 2_1011_1010.jpg
del 2_1011_1011.jpg
del 2_1011_1100.jpg
del 2_1011_1101.jpg
del 2_1011_1110.jpg
del 2_1011_1111.jpg
del 2_1100_0000.jpg
del 2_1100_0001.jpg
del 2_1100_0010.jpg
del 2_1100_0011.jpg
del 2_1100_0100.jpg
del 2_1100_0101.jpg
del 2_1100_0110.jpg
del 2_1100_0111.jpg
del 2_1100_1000.jpg
del 2_1100_1001.jpg
del 2_1100_1010.jpg
del 2_1100_1011.jpg
del 2_1100_1100.jpg
del 2_1100_1101.jpg
del 2_1100_1110.jpg
del 2_1100_1111.jpg
del 2_1101_0000.jpg
del 2_1101_0001.jpg
del 2_1101_0010.jpg
del 2_1101_0011.jpg
del 2_1101_0100.jpg
del 2_1101_0101.jpg
del 2_1101_0110.jpg
del 2_1101_0111.jpg
del 2_1101_1000.jpg
del 2_1101_1001.jpg
del 2_1101_1010.jpg
del 2_1101_1011.jpg
del 2_1101_1100.jpg
del 2_1101_1101.jpg
del 2_1101_1110.jpg
del 2_1101_1111.jpg
del 2_1110_0000.jpg
del 2_1110_0001.jpg
del 2_1110_0010.jpg
del 2_1110_0011.jpg
del 2_1110_0100.jpg
del 2_1110_0101.jpg
del 2_1110_0110.jpg
del 2_1110_0111.jpg
del 2_1110_1000.jpg
del 2_1110_1001.jpg
del 2_1110_1010.jpg
del 2_1110_1011.jpg
del 2_1110_1100.jpg
del 2_1110_1101.jpg
del 2_1110_1110.jpg
del 2_1110_1111.jpg
del 2_1111_0000.jpg
del 2_1111_0001.jpg
del 2_1111_0010.jpg
del 2_1111_0011.jpg
del 2_1111_0100.jpg
del 2_1111_0101.jpg
del 2_1111_0110.jpg
del 2_1111_0111.jpg
del 2_1111_1000.jpg
del 2_1111_1001.jpg
del 2_1111_1010.jpg
del 2_1111_1011.jpg
del 2_1111_1100.jpg
del 2_1111_1101.jpg
del 2_1111_1110.jpg
del 2_1111_1111.jpg
del 3_0000_0000.jpg
del 3_0000_0001.jpg
del 3_0000_0010.jpg
del 3_0000_0011.jpg
del 3_0000_0100.jpg
del 3_0000_0101.jpg
del 3_0000_0110.jpg
del 3_0000_0111.jpg
del 3_0000_1000.jpg
del 3_0000_1001.jpg
del 3_0000_1010.jpg
del 3_0000_1011.jpg
del 3_0000_1100.jpg
del 3_0000_1101.jpg
del 3_0000_1110.jpg
del 3_0000_1111.jpg
del 3_0001_0000.jpg
del 3_0001_0001.jpg
del 3_0001_0010.jpg
del 3_0001_0011.jpg
del 3_0001_0100.jpg
del 3_0001_0101.jpg
del 3_0001_0110.jpg
del 3_0001_0111.jpg
del 3_0001_1000.jpg
del 3_0001_1001.jpg
del 3_0001_1010.jpg
del 3_0001_1011.jpg
del 3_0001_1100.jpg
del 3_0001_1101.jpg
del 3_0001_1110.jpg
del 3_0001_1111.jpg
del 3_0010_0000.jpg
del 3_0010_0001.jpg
del 3_0010_0010.jpg
del 3_0010_0011.jpg
del 3_0010_0100.jpg
del 3_0010_0101.jpg
del 3_0010_0110.jpg
del 3_0010_0111.jpg
del 3_0010_1000.jpg
del 3_0010_1001.jpg
del 3_0010_1010.jpg
del 3_0010_1011.jpg
del 3_0010_1100.jpg
del 3_0010_1101.jpg
del 3_0010_1110.jpg
del 3_0010_1111.jpg
del 3_0011_0000.jpg
del 3_0011_0001.jpg
del 3_0011_0010.jpg
del 3_0011_0011.jpg
del 3_0011_0100.jpg
del 3_0011_0101.jpg
del 3_0011_0110.jpg
del 3_0011_0111.jpg
del 3_0011_1000.jpg
del 3_0011_1001.jpg
del 3_0011_1010.jpg
del 3_0011_1011.jpg
del 3_0011_1100.jpg
del 3_0011_1101.jpg
del 3_0011_1110.jpg
del 3_0011_1111.jpg
del 3_0100_0000.jpg
del 3_0100_0001.jpg
del 3_0100_0010.jpg
del 3_0100_0011.jpg
del 3_0100_0100.jpg
del 3_0100_0101.jpg
del 3_0100_0110.jpg
del 3_0100_0111.jpg
del 3_0100_1000.jpg
del 3_0100_1001.jpg
del 3_0100_1010.jpg
del 3_0100_1011.jpg
del 3_0100_1100.jpg
del 3_0100_1101.jpg
del 3_0100_1110.jpg
del 3_0100_1111.jpg
del 3_0101_0000.jpg
del 3_0101_0001.jpg
del 3_0101_0010.jpg
del 3_0101_0011.jpg
del 3_0101_0100.jpg
del 3_0101_0101.jpg
del 3_0101_0110.jpg
del 3_0101_0111.jpg
del 3_0101_1000.jpg
del 3_0101_1001.jpg
del 3_0101_1010.jpg
del 3_0101_1011.jpg
del 3_0101_1100.jpg
del 3_0101_1101.jpg
del 3_0101_1110.jpg
del 3_0101_1111.jpg
del 3_0110_0000.jpg
del 3_0110_0001.jpg
del 3_0110_0010.jpg
del 3_0110_0011.jpg
del 3_0110_0100.jpg
del 3_0110_0101.jpg
del 3_0110_0110.jpg
del 3_0110_0111.jpg
del 3_0110_1000.jpg
del 3_0110_1001.jpg
del 3_0110_1010.jpg
del 3_0110_1011.jpg
del 3_0110_1100.jpg
del 3_0110_1101.jpg
del 3_0110_1110.jpg
del 3_0110_1111.jpg
del 3_0111_0000.jpg
del 3_0111_0001.jpg
del 3_0111_0010.jpg
del 3_0111_0011.jpg
del 3_0111_0100.jpg
del 3_0111_0101.jpg
del 3_0111_0110.jpg
del 3_0111_0111.jpg
del 3_0111_1000.jpg
del 3_0111_1001.jpg
del 3_0111_1010.jpg
del 3_0111_1011.jpg
del 3_0111_1100.jpg
del 3_0111_1101.jpg
del 3_0111_1110.jpg
del 3_0111_1111.jpg
del 3_1000_0000.jpg
del 3_1000_0001.jpg
del 3_1000_0010.jpg
del 3_1000_0011.jpg
del 3_1000_0100.jpg
del 3_1000_0101.jpg
del 3_1000_0110.jpg
del 3_1000_0111.jpg
del 3_1000_1000.jpg
del 3_1000_1001.jpg
del 3_1000_1010.jpg
del 3_1000_1011.jpg
del 3_1000_1100.jpg
del 3_1000_1101.jpg
del 3_1000_1110.jpg
del 3_1000_1111.jpg
del 3_1001_0000.jpg
del 3_1001_0001.jpg
del 3_1001_0010.jpg
del 3_1001_0011.jpg
del 3_1001_0100.jpg
del 3_1001_0101.jpg
del 3_1001_0110.jpg
del 3_1001_0111.jpg
del 3_1001_1000.jpg
del 3_1001_1001.jpg
del 3_1001_1010.jpg
del 3_1001_1011.jpg
del 3_1001_1100.jpg
del 3_1001_1101.jpg
del 3_1001_1110.jpg
del 3_1001_1111.jpg
del 3_1010_0000.jpg
del 3_1010_0001.jpg
del 3_1010_0010.jpg
del 3_1010_0011.jpg
del 3_1010_0100.jpg
del 3_1010_0101.jpg
del 3_1010_0110.jpg
del 3_1010_0111.jpg
del 3_1010_1000.jpg
del 3_1010_1001.jpg
del 3_1010_1010.jpg
del 3_1010_1011.jpg
del 3_1010_1100.jpg
del 3_1010_1101.jpg
del 3_1010_1110.jpg
del 3_1010_1111.jpg
del 3_1011_0000.jpg
del 3_1011_0001.jpg
del 3_1011_0010.jpg
del 3_1011_0011.jpg
del 3_1011_0100.jpg
del 3_1011_0101.jpg
del 3_1011_0110.jpg
del 3_1011_0111.jpg
del 3_1011_1000.jpg
del 3_1011_1001.jpg
del 3_1011_1010.jpg
del 3_1011_1011.jpg
del 3_1011_1100.jpg
del 3_1011_1101.jpg
del 3_1011_1110.jpg
del 3_1011_1111.jpg
del 3_1100_0000.jpg
del 3_1100_0001.jpg
del 3_1100_0010.jpg
del 3_1100_0011.jpg
del 3_1100_0100.jpg
del 3_1100_0101.jpg
del 3_1100_0110.jpg
del 3_1100_0111.jpg
del 3_1100_1000.jpg
del 3_1100_1001.jpg
del 3_1100_1010.jpg
del 3_1100_1011.jpg
del 3_1100_1100.jpg
del 3_1100_1101.jpg
del 3_1100_1110.jpg
del 3_1100_1111.jpg
del 3_1101_0000.jpg
del 3_1101_0001.jpg
del 3_1101_0010.jpg
del 3_1101_0011.jpg
del 3_1101_0100.jpg
del 3_1101_0101.jpg
del 3_1101_0110.jpg
del 3_1101_0111.jpg
del 3_1101_1000.jpg
del 3_1101_1001.jpg
del 3_1101_1010.jpg
del 3_1101_1011.jpg
del 3_1101_1100.jpg
del 3_1101_1101.jpg
del 3_1101_1110.jpg
del 3_1101_1111.jpg
del 3_1110_0000.jpg
del 3_1110_0001.jpg
del 3_1110_0010.jpg
del 3_1110_0011.jpg
del 3_1110_0100.jpg
del 3_1110_0101.jpg
del 3_1110_0110.jpg
del 3_1110_0111.jpg
del 3_1110_1000.jpg
del 3_1110_1001.jpg
del 3_1110_1010.jpg
del 3_1110_1011.jpg
del 3_1110_1100.jpg
del 3_1110_1101.jpg
del 3_1110_1110.jpg
del 3_1110_1111.jpg
del 3_1111_0000.jpg
del 3_1111_0001.jpg
del 3_1111_0010.jpg
del 3_1111_0011.jpg
del 3_1111_0100.jpg
del 3_1111_0101.jpg
del 3_1111_0110.jpg
del 3_1111_0111.jpg
del 3_1111_1000.jpg
del 3_1111_1001.jpg
del 3_1111_1010.jpg
del 3_1111_1011.jpg
del 3_1111_1100.jpg
del 3_1111_1101.jpg
del 3_1111_1110.jpg
del 3_1111_1111.jpg
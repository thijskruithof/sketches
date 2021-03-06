// Generator
//
// A small (and very crappy) tool to generate the map tile images used by 939b106b 
// (https://thijskruithof.github.io/sketches/?sketch=939b106b)
//
// This will:
// 1. load a base albedo map and a base elevation map (typically very big images)
// 2. render shadows into the albedo map (very slow!)
// 3. render a gradient at the border of the images
// 4. write out albedo and elevation map images of fixed size (and also for each lod level)
//
//
// Copyright(C) 2020 Thijs Kruithof
//
// This program is free software : you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <https://www.gnu.org/licenses/>.


#include "lodepng.h"
#include "toojpeg\toojpeg.h"
#include "math.h"

#include <windows.h>
#undef NDEBUG
#include <assert.h>


#define ALBEDO_TILE_SIZE 512

//#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\albedo_0_0.png"
//#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\elevation_0_0.png"
//#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\albedo_16_0.png"
//#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\elevation_16_0.png"
//#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\albedo_30_0.png"
//#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\elevation_30_0.png"
//#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\albedo_24_0.png"
//#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\elevation_24_0.png"

#define OUTPUT_BASE_PATH "c:\\temp\\out"

#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\base_albedo.png"
#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\base_elevation.png"

#define SUN_HEADING DEG_TO_RAD(180.0f)
#define SUN_PITCH DEG_TO_RAD(25.0f)
#define SUN_HEADING_SPREAD DEG_TO_RAD(2.0f)
#define SUN_PITCH_SPREAD DEG_TO_RAD(0.5f)

#define NUM_SHADOW_RENDERER_THREADS 8

#define ELEVATION_MAP_PIXELOFFSET_X 5
#define ELEVATION_MAP_PIXELOFFSET_Y 20

#define SHADOW_AMOUNT 0.40f

#define ENABLE_RENDER_SHADOWS 1
#define ENABLE_RENDER_BORDERGRADIENT 1

// Source map images
unsigned int gMapWidth;
unsigned int gMapHeight;
Vec2 gMapSize;

unsigned char* gAlbedoMap;
unsigned char* gElevationMap;
float* gElevationMapF;


// Returns elevation [0..255], bilinear filtered
__forceinline float getElevation(const Vec3& pos)
{
    int px = (int)pos.mX;
    int py = (int)pos.mY;
    float wx = pos.mX - (float)px;
    float wy = pos.mY - (float)py;

    int offset = px + py * gMapWidth;

    return
        (1.0f - wx) * (1.0f - wy) * gElevationMapF[offset] +
        wx * (1.0f - wy) * gElevationMapF[offset + 1] +
        (1.0f - wx) * wy * gElevationMapF[offset + gMapWidth] +
        wx * wy * gElevationMapF[offset + gMapWidth + 1];

}



bool intersects(const Vec2& startPos, const Vec3& direction)
{
    assert(direction.mZ > 0.0f);

    Vec3 pos(startPos, 0.0f);
    pos.mZ = getElevation(pos) + 2.0f;

    float len2D = direction.XY().Length();

    // 2 pixel steps
    Vec3 step = direction * (1.0f / len2D);

    while (true)
    {
        pos += step;

        if (pos.mX < 1.0f || pos.mX >= gMapSize.mX - 3.0f ||
            pos.mY < 1.0f || pos.mY >= gMapSize.mY - 3.0f)
            return false;

        float elevation = getElevation(pos);

        if (pos.mZ < elevation - 5.0f)
            return true; // Into the terrain :'(

        if (pos.mZ > 255.0f)
            return false; // Above the max elevation
    }

    return false;
}


FILE* gSaveImageFile = nullptr;

void saveImage24(const unsigned char* src, const char* filename, int x, int y, int width, int height, int mapWidth, int mapHeight, unsigned char* tempBuffer)
{
    assert(x >= 0 && x <= (int)mapWidth - width);
    assert(y >= 0 && y <= (int)mapHeight - height);

    unsigned char* dest = tempBuffer;

    for (int ty = 0; ty < height; ++ty)
    {
        int srcPixeloffset = x + (y + ty)*mapWidth;
        
        // Copy a row (from RGBA to RGB)
        for (int tx = 0; tx < width; ++tx)
        {
            *(dest++) = src[(srcPixeloffset + tx) * 4];
            *(dest++) = src[(srcPixeloffset + tx) * 4 + 1];
            *(dest++) = src[(srcPixeloffset + tx) * 4 + 2];
        }
    }

    // Clear bottom rows (if image is not square)
    for (int ty = height; ty < width; ++ty)
        memset(tempBuffer + ty * width * 3, 0, width * 3);

    assert(gSaveImageFile == nullptr);
    gSaveImageFile = nullptr;
    fopen_s(&gSaveImageFile, filename, "wb");
    assert(gSaveImageFile != nullptr);

    bool success = TooJpeg::writeJpeg(
        [](unsigned char oneByte) { fputc(oneByte, gSaveImageFile); },
        tempBuffer,
        width,
        width,
        true, // isRGB
        80, // quality
        false, // downsample
        ""
    );

    assert(success);

    fclose(gSaveImageFile);
    gSaveImageFile = nullptr;   
}



void saveImageF(const float* src, const char* filename, int x, int y, int width, int height, int mapWidth, int mapHeight, unsigned char* tempBuffer)
{
    assert(x >= 0 && x <= (int)mapWidth - width);
    assert(y >= 0 && y <= (int)mapHeight - height);

    for (int ty = 0; ty < height; ++ty)
    {
        for (int tx = 0; tx < width; ++tx)
        {
            float v = src[x + tx + (y + ty)*mapWidth];
            unsigned char r = (unsigned char)v;
            
            tempBuffer[tx + (ty*width)] = r;
        }
    }

    // Clear bottom rows (if image is not square)
    for (int ty = height; ty < width; ++ty)
        memset(tempBuffer + ty * width, 0, width);

    assert(gSaveImageFile == nullptr);
    gSaveImageFile = nullptr;
    fopen_s(&gSaveImageFile, filename, "wb");
    assert(gSaveImageFile != nullptr);

    bool success = TooJpeg::writeJpeg(
        [](unsigned char oneByte) { fputc(oneByte, gSaveImageFile); },
        tempBuffer,
        width,
        width,
        false, // isRGB
        70, // quality
        false, // downsample
        ""
    );

    assert(success);

    fclose(gSaveImageFile);
    gSaveImageFile = nullptr;
}



void half(unsigned char* src, unsigned int width, unsigned int height)
{
    unsigned int halfedWidth = width / 2;
    unsigned int halfedHeight = height / 2;
    unsigned char* halfed = (unsigned char*)malloc(halfedWidth*halfedHeight * 4);

    unsigned __int32* src32 = (unsigned __int32*)src;
    unsigned __int32* halfed32 = (unsigned __int32*)halfed;

    // Linear downsample
    for (int y = 0; y < (int)height; y += 2)
    {
        for (int x = 0; x < (int)width; x += 2)
        {
            unsigned __int32 a = src32[x + y * width];
            unsigned __int32 b = src32[x + y * width + 1];
            unsigned __int32 c = src32[x + (y+1) * width];
            unsigned __int32 d = src32[x + (y + 1) * width + 1];

            unsigned __int32 c0 = ((a & 0xff) + (b & 0xff) + (c & 0xff) + (d & 0xff)) / 4;
            unsigned __int32 c1 = ((((a >> 8) & 0xff) + ((b >> 8) & 0xff) + ((c >> 8) & 0xff) + ((d >> 8) & 0xff)) / 4) << 8;
            unsigned __int32 c2 = ((((a >> 16) & 0xff) + ((b >> 16) & 0xff) + ((c >> 16) & 0xff) + ((d >> 16) & 0xff)) / 4) << 16;
            unsigned __int32 c3 = ((((a >> 24) & 0xff) + ((b >> 24) & 0xff) + ((c >> 24) & 0xff) + ((d >> 24) & 0xff)) / 4) << 24;

            halfed32[x/2 + (y/2) * halfedWidth] = c3 | c2 | c1 | c0;
        }
    }

    // Copy back
    memcpy(src, halfed, halfedWidth*halfedHeight * 4);

    free(halfed);
}




void halfF(float* src, unsigned int width, unsigned int height)
{
    unsigned int halfedWidth = width / 2;
    unsigned int halfedHeight = height / 2;
    float* halfed = (float*)malloc(halfedWidth*halfedHeight * 4);

    // Linear downsample
    for (int y = 0; y < (int)height; y += 2)
    {
        for (int x = 0; x < (int)width; x += 2)
        {
            float a = src[x + y * width];
            float b = src[x + y * width + 1];
            float c = src[x + (y + 1) * width];
            float d = src[x + (y + 1) * width + 1];

            halfed[x / 2 + (y / 2) * halfedWidth] = (a + b + c + d) / 4.0f;
        }
    }

    // Copy back
    memcpy(src, halfed, halfedWidth*halfedHeight * 4);

    free(halfed);
}


struct ShadowRendererParams
{
    int startY;
    int endY;
    DWORD threadID;
};


Vec3 getHeadingPitchDirection(float heading, float pitch)
{
    return Vec3(cosf(heading)*cosf(pitch), sinf(heading)*cosf(pitch), sinf(pitch));
}


DWORD WINAPI ShadowThreadFunction(LPVOID lpParam)
{
    ShadowRendererParams* params = (ShadowRendererParams*)lpParam;

    Vec3 sunDirection[5];       
    sunDirection[0] = getHeadingPitchDirection(SUN_HEADING, SUN_PITCH);
    sunDirection[1] = getHeadingPitchDirection(SUN_HEADING + SUN_HEADING_SPREAD, SUN_PITCH);
    sunDirection[2] = getHeadingPitchDirection(SUN_HEADING - SUN_HEADING_SPREAD, SUN_PITCH);
    sunDirection[3] = getHeadingPitchDirection(SUN_HEADING, SUN_PITCH + SUN_PITCH_SPREAD);
    sunDirection[4] = getHeadingPitchDirection(SUN_HEADING, SUN_PITCH - SUN_PITCH_SPREAD);

    for (int y = params->startY; y <= params->endY; y++)
    {
        for (int x = 0; x < (int)gMapWidth; ++x)
        {
            Vec2 pos;
            pos.mX = min((float)x, gMapSize.mX - 2.0f);
            pos.mY = min((float)y, gMapSize.mY - 2.0f);

            float amount = 0.0f;

            if (intersects(pos, sunDirection[0])) amount += 1.0f;
            if (intersects(pos, sunDirection[1])) amount += 1.0f;
            if (intersects(pos, sunDirection[2])) amount += 1.0f;
            if (intersects(pos, sunDirection[3])) amount += 1.0f;
            if (intersects(pos, sunDirection[4])) amount += 1.0f;

            float intensity = 1.0f - amount * (SHADOW_AMOUNT / 5.0f);

            // Dim RGB
            gAlbedoMap[(x + y * gMapWidth) * 4] = (unsigned char)(gAlbedoMap[(x + y * gMapWidth) * 4] * intensity);
            gAlbedoMap[(x + y * gMapWidth) * 4 + 1] = (unsigned char)(gAlbedoMap[(x + y * gMapWidth) * 4 + 1] * intensity);
            gAlbedoMap[(x + y * gMapWidth) * 4 + 2] = (unsigned char)(gAlbedoMap[(x + y * gMapWidth) * 4 + 2] * intensity);
        }
    }

    return 0;
}



int main()
{
    unsigned error;
    
    printf("Loading albedo...\n");
    error = lodepng_decode32_file(&gAlbedoMap, &gMapWidth, &gMapHeight, ALBEDO_BASE_IMAGE_FN);
    assert(error == 0);
    assert(gMapWidth % ALBEDO_TILE_SIZE == 0);
    assert(gMapHeight % ALBEDO_TILE_SIZE == 0);
    gMapSize = Vec2((float)gMapWidth, (float)gMapHeight);

    printf("Loading elevation...\n");
    unsigned int elevationWidth = 0;
    unsigned int elevationHeight = 0;
    error = lodepng_decode32_file(&gElevationMap, &elevationWidth, &elevationHeight, ELEVATION_BASE_IMAGE_FN);
    assert(error == 0);
    assert(elevationWidth == gMapWidth);
    assert(elevationHeight == gMapHeight);

    gElevationMapF = (float*)gElevationMap;


    printf("Converting elevation map to float...\n");

    // Convert from u8 to f32
    for (unsigned int i = 0; i < gMapWidth*gMapHeight; ++i)
        gElevationMapF[i] = ((float)gElevationMap[i * 4 + 3] * (float)gElevationMap[i * 4 + 2]) / 255.0f;


    printf("Loaded %dx%d albedo and elevation maps.\n", gMapWidth, gMapHeight);


#if ENABLE_RENDER_SHADOWS
    printf("Rendering shadows...\n");

    {
        ShadowRendererParams rendererParams[NUM_SHADOW_RENDERER_THREADS];
        HANDLE threadHandles[NUM_SHADOW_RENDERER_THREADS];

        for (int i = 0; i < NUM_SHADOW_RENDERER_THREADS; ++i)
        {
            rendererParams[i].startY = i * (gMapHeight / NUM_SHADOW_RENDERER_THREADS);
            rendererParams[i].endY = rendererParams[i].startY + (gMapHeight / NUM_SHADOW_RENDERER_THREADS) - 1;
        }

        for (int i = 0; i < NUM_SHADOW_RENDERER_THREADS; ++i)
        {
            threadHandles[i] =
                CreateThread(
                    NULL,                           // default security attributes
                    0,                              // use default stack size  
                    ShadowThreadFunction,           // thread function name
                    &rendererParams[i],             // argument to thread function 
                    0,                              // use default creation flags 
                    &rendererParams[i].threadID);   // returns the thread identifier 

            assert(threadHandles[i] != NULL);
        }

        WaitForMultipleObjects(NUM_SHADOW_RENDERER_THREADS, threadHandles, TRUE, INFINITE);

        for (int i = 0; i<NUM_SHADOW_RENDERER_THREADS; i++)
            CloseHandle(threadHandles[i]);
    }
#endif


#if ENABLE_RENDER_BORDERGRADIENT
    printf("Rendering border gradient.\n");

    for (int y = 0; y < (int)gMapHeight; y++)
    {
        // dist to y=255 and y=h-255
        float yd = max(0, abs(y - (int)gMapHeight / 2) - (((int)gMapHeight / 2) - 255)) / 255.0f;
        float yd2 = yd * yd;

        for (int x = 0; x < (int)gMapWidth; ++x)
        {
            float xd = max(0, abs(x - (int)gMapWidth / 2) - (((int)gMapWidth / 2) - 255)) / 255.0f;

            float distFromEdge = sqrtf(xd*xd + yd2);
            float intensity = 1.0f - min(distFromEdge, 1.0f);

            gAlbedoMap[(x + y * gMapWidth) * 4]     = (unsigned char)(gAlbedoMap[(x + y * gMapWidth) * 4] * intensity);
            gAlbedoMap[(x + y * gMapWidth) * 4 + 1] = (unsigned char)(gAlbedoMap[(x + y * gMapWidth) * 4 + 1] * intensity);
            gAlbedoMap[(x + y * gMapWidth) * 4 + 2] = (unsigned char)(gAlbedoMap[(x + y * gMapWidth) * 4 + 2] * intensity);
        }
    }
#endif


    printf("Moving elevation map a little (to fix alignment)...\n");

    for (int ty = (int)gMapHeight - 1; ty >= 0; --ty)
    {
        int tty = max(0, ty - ELEVATION_MAP_PIXELOFFSET_Y);

        for (int tx = (int)gMapWidth - 1; tx >= 0; --tx)
        {
            int ttx = max(0, tx - ELEVATION_MAP_PIXELOFFSET_X);

            gElevationMapF[tx + (ty*gMapWidth)] = gElevationMapF[ttx + (tty*gMapWidth)];
        }
    }


    printf("Halfing res of elevation.\n");
    halfF(gElevationMapF, gMapWidth, gMapHeight);

    printf("Saving tile images.\n");

    unsigned char* tempBuffer = new unsigned char[ALBEDO_TILE_SIZE*ALBEDO_TILE_SIZE * 4];

    CreateDirectoryA(OUTPUT_BASE_PATH, NULL);

    int albedoMapWidth = gMapWidth;
    int albedoMapHeight = gMapHeight;

    int lod = 0;
    while (true)
    {
        printf("Lod %d...\n", lod);

        char lodpath[512];
        sprintf_s(lodpath, 512, "%s\\%d", OUTPUT_BASE_PATH, lod);
        CreateDirectoryA(lodpath, NULL);

        for (int y = 0; y < albedoMapHeight; y += ALBEDO_TILE_SIZE)
        {
            char path[512];
            sprintf_s(path, 512, "%s\\%d\\%d", OUTPUT_BASE_PATH, lod, y / ALBEDO_TILE_SIZE);
            CreateDirectoryA(path, NULL);

            for (int x = 0; x < albedoMapWidth; x += ALBEDO_TILE_SIZE)
            {
                char fn[512];
                char fn_e[512];
                sprintf_s(fn, 512, "%s\\%d.jpg", path, x / ALBEDO_TILE_SIZE);
                sprintf_s(fn_e, 512, "%s\\%d_e.jpg", path, x / ALBEDO_TILE_SIZE);

                printf("Writing %s.\n", fn);
                saveImage24(gAlbedoMap, fn, x, y, min(ALBEDO_TILE_SIZE, albedoMapWidth), min(ALBEDO_TILE_SIZE, albedoMapHeight), albedoMapWidth, albedoMapHeight, tempBuffer);

                printf("Writing %s.\n", fn_e);
                saveImageF(gElevationMapF, fn_e, x/2, y/2, min(ALBEDO_TILE_SIZE/2, albedoMapWidth/2), min(ALBEDO_TILE_SIZE/2, albedoMapHeight/2), albedoMapWidth/2, albedoMapHeight/2, tempBuffer);
            }
        }

        if (albedoMapWidth <= ALBEDO_TILE_SIZE && albedoMapHeight <= ALBEDO_TILE_SIZE)
            break;

        // Half our source buffers
        half(gAlbedoMap, albedoMapWidth, albedoMapHeight);
        halfF(gElevationMapF, albedoMapWidth/2, albedoMapHeight/2);
        lod++;
        albedoMapWidth /= 2;
        albedoMapHeight /= 2;
    }    

    delete[] tempBuffer;


    free(gAlbedoMap);
    free(gElevationMap);

    return 0;
}


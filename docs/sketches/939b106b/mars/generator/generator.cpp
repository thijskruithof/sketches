// generator.cpp : Defines the entry point for the console application.
//

#include "lodepng.h"
#include "math.h"

#include <windows.h>
#undef NDEBUG
#include <assert.h> // for assert()


#define ALBEDO_TILE_SIZE 512

#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\combined_huger.png"
#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\elevation.png"

#define SUN_HEADING DEG_TO_RAD(15.0f)
#define SUN_PITCH DEG_TO_RAD(10.0f)
#define SUN_HEADING_SPREAD DEG_TO_RAD(0.5f)
#define SUN_PITCH_SPREAD DEG_TO_RAD(0.5f)

#define NUM_SHADOW_RENDERER_THREADS 8


// Base albedo image
unsigned char* gAlbedoMap;
unsigned int gAlbedoMapWidth;
unsigned int gAlbedoMapHeight;
unsigned char* gAlbedoImageBuffer; 

// Base elevation image
unsigned char* gElevationMap;
float* gElevationMapF;
Vec2 gElevationMapSize;
unsigned int gElevationMapWidth;
unsigned int gElevationMapHeight;



// Returns elevation [0..255], bilinear filtered
float getElevation(const Vec3& pos)
{
    //if (pos.mX < 0.0f || pos.mX >= gElevationMapSize.mX-1 ||
    //    pos.mY < 0.0f || pos.mY >= gElevationMapSize.mY-1)
    //{
    //    return -1.0f;
    //}


    int px = (int)pos.mX;
    int py = (int)pos.mY;

    int offset = px + py * gElevationMapWidth;

    return gElevationMapF[offset];

    // Has R?
    //if (px < (int)gElevationMapWidth)
    //{
        //float wx = pos.mX - (float)px;

        //// Has B?
        ////if (py < (int)gElevationMapHeight)
        //{
        //    float wy = pos.mY - (float)py;

        //    return
        //        (1.0f - wx) * (1.0f - wy) * gElevationMap[offset] +
        //        wx * (1.0f - wy) * gElevationMap[offset + 1] +
        //        (1.0f - wx) * wy * gElevationMap[offset + gElevationMapWidth * 4] +
        //        wx * wy * gElevationMap[offset + gElevationMapWidth * 4 + 1];
        //}
    //    // No B, only a R
    //    else
    //    {
    //        return
    //            (1.0f - wx) * gElevationMap[offset] +
    //            wx * gElevationMap[offset + 1];
    //    }
    //}
    //// No R, maybe a B?
    //else if (py < (int)gElevationMapHeight)
    //{
    //    float wy = pos.mY - (float)py;

    //    return
    //        (1.0f - wy) * gElevationMap[offset] +
    //        wy * gElevationMap[offset + gElevationMapWidth * 4];
    //}
    //else
    //{
    //    return gElevationMap[offset];
    //}
}



bool intersects(const Vec2& startPos, const Vec3& direction)
{
    assert(direction.mZ > 0.0f);

    Vec3 pos = Vec3(startPos, getElevation(Vec3(startPos, 0.0f)) + 0.01f);

    float len2D = direction.XY().Length();

    // 2 pixel steps
    Vec3 step = direction * (2.0f / len2D);

    while (true)
    {
        pos += step;

        if (pos.mX < 0.0f || pos.mX >= gElevationMapSize.mX ||
            pos.mY < 0.0f || pos.mY >= gElevationMapSize.mY)
            return false;

        float elevation = getElevation(pos);

        if (pos.mZ < elevation)
            return true; // Into the terrain :'(

        if (pos.mZ > 255.0f)
            return false; // Above the max elevation
    }

    return false;
}



void saveAlbedoImage(const char* filename, int x, int y)
{
    assert(x >= 0 && x <= (int)gAlbedoMapWidth - ALBEDO_TILE_SIZE);
    assert(y >= 0 && y <= (int)gAlbedoMapHeight - ALBEDO_TILE_SIZE);

    for (int ty = 0; ty < ALBEDO_TILE_SIZE; ++ty)
    {
        int srcPixeloffset = x + (y + ty)*gAlbedoMapWidth;
        
        // Memcpy a single row
        memcpy(gAlbedoImageBuffer + ty * ALBEDO_TILE_SIZE * 4, gAlbedoMap + srcPixeloffset * 4, ALBEDO_TILE_SIZE * 4);
    }

    unsigned error = lodepng_encode32_file(filename, gAlbedoImageBuffer, ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE);
    assert(error == 0);
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
        //for (int x = 0; x < (int)gAlbedoMapWidth; ++x)
        for (int x=0; x<2* ALBEDO_TILE_SIZE; ++x)
        {
            Vec2 pos((float)x, (float)y);

            float amount = 0.0f;

            if (intersects(pos, sunDirection[0])) amount += 1.0f;
            if (intersects(pos, sunDirection[1])) amount += 1.0f;
            if (intersects(pos, sunDirection[2])) amount += 1.0f;
            if (intersects(pos, sunDirection[3])) amount += 1.0f;
            if (intersects(pos, sunDirection[4])) amount += 1.0f;

            float intensity = 1.0f - amount * 0.1f;

            // Dim RGB
            gAlbedoMap[(x + y * gAlbedoMapWidth) * 4] = (unsigned char)(gAlbedoMap[(x + y * gAlbedoMapWidth) * 4] * intensity);
            gAlbedoMap[(x + y * gAlbedoMapWidth) * 4 + 1] = (unsigned char)(gAlbedoMap[(x + y * gAlbedoMapWidth) * 4 + 1] * intensity);
            gAlbedoMap[(x + y * gAlbedoMapWidth) * 4 + 2] = (unsigned char)(gAlbedoMap[(x + y * gAlbedoMapWidth) * 4 + 2] * intensity);
        }
    }

    return 0;
}



int main()
{
    unsigned error;
    
    printf("Loading albedo...\n");
    error = lodepng_decode32_file(&gAlbedoMap, &gAlbedoMapWidth, &gAlbedoMapHeight, ALBEDO_BASE_IMAGE_FN);
    assert(error == 0);
    assert(gAlbedoMapWidth % ALBEDO_TILE_SIZE == 0);
    assert(gAlbedoMapHeight % ALBEDO_TILE_SIZE == 0);

    printf("Loading elevation...\n");
    error = lodepng_decode32_file(&gElevationMap, &gElevationMapWidth, &gElevationMapHeight, ELEVATION_BASE_IMAGE_FN);
    assert(error == 0);
    assert(gElevationMapWidth == gAlbedoMapWidth);
    assert(gElevationMapHeight == gAlbedoMapHeight);

    gElevationMapF = (float*)gElevationMap;
    gElevationMapSize = Vec2((float)gElevationMapWidth, (float)gElevationMapHeight);

    printf("Loaded %dx%d albedo and elevation maps.", gAlbedoMapWidth, gAlbedoMapHeight);


    printf("Converting elevation map...\n");

    // Convert from u8 to f32
    for (unsigned int i = 0; i < gElevationMapWidth*gElevationMapHeight; ++i)
        gElevationMapF[i] = (float)gElevationMap[i * 4];

    printf("Rendering shadows...\n");

    {


        ShadowRendererParams rendererParams[NUM_SHADOW_RENDERER_THREADS];
        HANDLE threadHandles[NUM_SHADOW_RENDERER_THREADS];

        for (int i = 0; i < NUM_SHADOW_RENDERER_THREADS; ++i)
        {
            rendererParams[i].startY = i * (gAlbedoMapHeight / NUM_SHADOW_RENDERER_THREADS);
            rendererParams[i].endY = rendererParams[i].startY + (gAlbedoMapHeight / NUM_SHADOW_RENDERER_THREADS) - 1;
        }

        for (int i = 0; i < NUM_SHADOW_RENDERER_THREADS; ++i)
        {
            threadHandles[i] =
                CreateThread(
                    NULL,                   // default security attributes
                    0,                      // use default stack size  
                    ShadowThreadFunction,       // thread function name
                    &rendererParams[i],          // argument to thread function 
                    0,                      // use default creation flags 
                    &rendererParams[i].threadID);   // returns the thread identifier 

            assert(threadHandles[i] != NULL);
        }

        WaitForMultipleObjects(NUM_SHADOW_RENDERER_THREADS, threadHandles, TRUE, INFINITE);

        for (int i = 0; i<NUM_SHADOW_RENDERER_THREADS; i++)
            CloseHandle(threadHandles[i]);
    }



#if 0
    printf("Modifying.\n");

    for (int y = 0; y < gAlbedoMapHeight; y++)
    {
        float yd = max(1.0f - (float)y / 255.0f, 0.0f); // dist to y=1
        float yd2 = yd * yd;

        for (int x = 0; x < gAlbedoMapWidth; ++x)
        {
            float xd = max(1.0f - (float)x / 255.0f, 0.0f);

            float distFromEdge = sqrtf(xd*xd + yd2);
            float intensity = 1.0f - min(distFromEdge, 1.0f);

            gAlbedoMap[(x + y * gAlbedoMapWidth) * 4] = (gAlbedoMap[(x + y * gAlbedoMapWidth) * 4] * intensity);
            gAlbedoMap[(x + y * gAlbedoMapWidth) * 4 + 1] = (gAlbedoMap[(x + y * gAlbedoMapWidth) * 4 + 1] * intensity);
            gAlbedoMap[(x + y * gAlbedoMapWidth) * 4 + 2] = (gAlbedoMap[(x + y * gAlbedoMapWidth) * 4 + 2] * intensity);
        }
    }

#endif

    printf("Saving.\n");



    gAlbedoImageBuffer = new unsigned char[ALBEDO_TILE_SIZE*ALBEDO_TILE_SIZE * 4];

    for (int y = 0; y < (int)gAlbedoMapHeight; y += ALBEDO_TILE_SIZE)
    {
        for (int x = 0; x < (int)gAlbedoMapWidth; x += ALBEDO_TILE_SIZE)
        {
            printf("Saving image y=%d, x=%d...\n", y, x);
            saveAlbedoImage(x == 0 ? "c:\\temp\\test.png" : "c:\\temp\\test1.png", x, y);
            printf("Done.\n");

            if (x >= ALBEDO_TILE_SIZE)
                break;
        }

        break;
    }

    delete[] gAlbedoImageBuffer;



    free(gAlbedoMap);
    free(gElevationMap);

    return 0;
}


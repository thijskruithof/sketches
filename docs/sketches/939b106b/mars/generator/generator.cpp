// generator.cpp : Defines the entry point for the console application.
//

#include "lodepng.h"
#include "math.h"

#include <windows.h>
#undef NDEBUG
#include <assert.h> // for assert()


#define ALBEDO_TILE_SIZE 512

//#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\albedo_0_0.png"
//#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\elevation_0_0.png"

#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\albedo_16_0.png"
#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\elevation_16_0.png"


//#define ALBEDO_BASE_IMAGE_FN "c:\\temp\\combined_huger.png"
//#define ELEVATION_BASE_IMAGE_FN "c:\\temp\\elevation.png"

#define SUN_HEADING DEG_TO_RAD(180.0f)
#define SUN_PITCH DEG_TO_RAD(25.0f)
#define SUN_HEADING_SPREAD DEG_TO_RAD(2.0f)
#define SUN_PITCH_SPREAD DEG_TO_RAD(0.5f)

#define NUM_SHADOW_RENDERER_THREADS 8

#define ELEVATION_MAP_OFFSET_X -5.0f
#define ELEVATION_MAP_OFFSET_Y -20.0f

#define SHADOW_AMOUNT 0.25f

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


bool getAverageElevation(const Vec3& pos, float* elevation)
{       
    if (pos.mX < 1.0f || pos.mX >= gMapSize.mX - 3.0f ||
        pos.mY < 1.0f || pos.mY >= gMapSize.mY - 3.0f)
        return false;

#if 0
    float summedElevation =
        getElevation(pos) +
        getElevation(pos + Vec3(-1.0f, 0.0f, 0.0f)) +
        getElevation(pos + Vec3( 1.0f, 0.0f, 0.0f)) +
        getElevation(pos + Vec3( 0.0f,-1.0f, 0.0f)) +
        getElevation(pos + Vec3( 0.0f, 1.0f, 0.0f));

    *elevation = summedElevation / 5.0f;
#else 
    *elevation = getElevation(pos);
#endif 
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

        float elevation;
        if (!getAverageElevation(pos, &elevation))
            return false;

        if (pos.mZ < elevation - 5.0f)
            return true; // Into the terrain :'(

        if (pos.mZ > 255.0f)
            return false; // Above the max elevation
    }

    return false;
}



void saveImage(const unsigned char* src, const char* filename, int x, int y, int size, unsigned char* tempBuffer)
{
    assert(x >= 0 && x <= (int)gMapWidth - size);
    assert(y >= 0 && y <= (int)gMapHeight - size);

    for (int ty = 0; ty < size; ++ty)
    {
        int srcPixeloffset = x + (y + ty)*gMapWidth;
        
        // Memcpy a single row
        memcpy(tempBuffer + ty * size * 4, src + srcPixeloffset * 4, size * 4);
    }

    unsigned char* buffer;
    size_t buffersize;
    LodePNGState state;
    lodepng_state_init(&state);
    state.info_raw.colortype = LCT_RGBA;
    state.info_raw.bitdepth = 8;
    state.info_png.color.colortype = LCT_RGBA;
    state.info_png.color.bitdepth = 8;
    state.encoder.auto_convert = false;
    lodepng_encode(&buffer, &buffersize, tempBuffer, size, size, &state);
    assert(state.error == 0);
    lodepng_state_cleanup(&state);

    unsigned int error = lodepng_save_file(buffer, buffersize, filename);
    assert(error == 0);
    free(buffer);    
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
            pos.mX = max(min((float)x + ELEVATION_MAP_OFFSET_X, gMapSize.mX - 2.0f), 0.0f);
            pos.mY = max(min((float)y + ELEVATION_MAP_OFFSET_Y, gMapSize.mY - 2.0f), 0.0f);


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

    printf("Loaded %dx%d albedo and elevation maps.\n", gMapWidth, gMapHeight);


#if 1
    printf("Converting elevation map...\n");

    // Convert from u8 to f32
    for (unsigned int i = 0; i < gMapWidth*gMapHeight; ++i)
        gElevationMapF[i] = ((float)gElevationMap[i * 4 + 3]*(float)gElevationMap[i * 4 + 2]) / 255.0f;


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



    //unsigned char* tempBuffer = new unsigned char[ALBEDO_TILE_SIZE*ALBEDO_TILE_SIZE*2*2 * 4];
    //saveImage(gAlbedoMap, "c:\\temp\\albedo_0_0.png", 0, 0, ALBEDO_TILE_SIZE*2, tempBuffer);
    //saveImage(gElevationMap, "c:\\temp\\elevation_0_0.png", 0, 0, ALBEDO_TILE_SIZE * 2, tempBuffer);
    //saveImage(gAlbedoMap, "c:\\temp\\albedo_16_0.png", 0, 16*ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE * 2, tempBuffer);
    //saveImage(gElevationMap, "c:\\temp\\elevation_16_0.png", 0, 16 * ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE * 2, tempBuffer);

    unsigned char* tempBuffer = new unsigned char[ALBEDO_TILE_SIZE*ALBEDO_TILE_SIZE * 4];
    //saveImage(gAlbedoMap, "c:\\temp\\test4_0_0.png", 0, 0, ALBEDO_TILE_SIZE, tempBuffer);
    //saveImage(gAlbedoMap, "c:\\temp\\test4_0_1.png", ALBEDO_TILE_SIZE, 0, ALBEDO_TILE_SIZE, tempBuffer);
    //saveImage(gAlbedoMap, "c:\\temp\\test4_1_0.png", 0, ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE, tempBuffer);
    //saveImage(gAlbedoMap, "c:\\temp\\test4_1_1.png", ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE, tempBuffer);
    saveImage(gAlbedoMap, "c:\\temp\\test4_16_0.png", 0, 0, ALBEDO_TILE_SIZE, tempBuffer);
    saveImage(gAlbedoMap, "c:\\temp\\test4_16_1.png", ALBEDO_TILE_SIZE, 0, ALBEDO_TILE_SIZE, tempBuffer);
    saveImage(gAlbedoMap, "c:\\temp\\test4_17_0.png", 0, ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE, tempBuffer);
    saveImage(gAlbedoMap, "c:\\temp\\test4_17_1.png", ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE, ALBEDO_TILE_SIZE, tempBuffer);


    delete[] tempBuffer;


    free(gAlbedoMap);
    free(gElevationMap);

    return 0;
}


attribute vec3 aPosition;
attribute vec2 aTexCoord;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

uniform vec2 uAlbedoTextureTopLeft;
uniform vec2 uAlbedoTextureSize;
uniform vec2 uElevationTextureTopLeft;
uniform vec2 uElevationTextureSize;

varying vec2 vAlbedoUV;
varying vec2 vElevationUV;
varying vec3 vPositionView;

void main() 
{
    vec4 positionVec4 = vec4(aPosition, 1.0);
    gl_Position = uProjectionMatrix * uModelViewMatrix * positionVec4;

    vPositionView = (uModelViewMatrix * positionVec4).xyz;

    vAlbedoUV = uAlbedoTextureTopLeft + aTexCoord * uAlbedoTextureSize;
    vElevationUV = uElevationTextureTopLeft + aTexCoord * uElevationTextureSize;
}

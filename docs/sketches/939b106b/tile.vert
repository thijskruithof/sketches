precision highp float;

attribute vec3 aPosition;
attribute vec2 aTexCoord;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

uniform vec2 uAlbedoTextureTopLeft;
uniform vec2 uAlbedoTextureSize;
uniform vec2 uElevationTextureTopLeft;
uniform vec2 uElevationTextureSize;

uniform vec2 uUVTopLeft;
uniform vec2 uUVBottomRight;

varying vec2 vUV;
varying vec3 vPositionView;
varying vec3 vEyeGroundNormal;
varying vec3 vEyeGroundTangent;
varying vec3 vEyeGroundBitangent;

void main() 
{
    vec4 positionVec4 = vec4(aPosition, 1.0);
    gl_Position = uProjectionMatrix * uModelViewMatrix * positionVec4;

    vUV = mix(uUVTopLeft, uUVBottomRight, aTexCoord);

    vPositionView = (uModelViewMatrix * positionVec4).xyz;

    vEyeGroundNormal = (uModelViewMatrix * vec4(0.0, 0.0, 1.0, 0.0)).xyz;
    vEyeGroundTangent = (uModelViewMatrix * vec4(1.0, 0.0, 0.0, 0.0)).xyz;
    vEyeGroundBitangent = cross(vEyeGroundNormal, vEyeGroundTangent);
}

attribute vec3 aPosition;
attribute vec2 aTexCoord;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

uniform vec2 uScreenOffset;
uniform float uPlaneZ;

varying vec3 vEyeGroundNormal;
varying vec3 vEyeGroundTangent;
varying vec3 vEyeGroundBitangent;

varying vec2 vUV;
varying vec3 vPositionView;

void main() 
{
    vec4 positionVec4 = vec4(aPosition, 1.0);
    gl_Position = uProjectionMatrix * uModelViewMatrix * positionVec4;    

    vUV.x = aTexCoord.x * 0.5 + 0.25;
    vUV.y = (aTexCoord.y) * 0.5 + 0.25;
    vPositionView = (uModelViewMatrix * positionVec4).xyz;

    vEyeGroundNormal = (uModelViewMatrix * vec4(0.0, 0.0, 1.0, 0.0)).xyz;
    vEyeGroundTangent = (uModelViewMatrix * vec4(1.0, 0.0, 0.0, 0.0)).xyz;
    vEyeGroundBitangent = cross(vEyeGroundNormal, vEyeGroundTangent);
}

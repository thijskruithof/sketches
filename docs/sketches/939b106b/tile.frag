precision mediump float;


varying vec2 vAlbedoUV;
varying vec2 vElevationUV;

uniform sampler2D uAlbedoTexture;
uniform sampler2D uElevationTexture;


void main() 
{
    gl_FragColor = vec4(texture2D(uAlbedoTexture, vAlbedoUV).xyz, texture2D(uElevationTexture, vElevationUV).x);
}
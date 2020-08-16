precision mediump float;


varying vec2 vAlbedoUV;
varying vec2 vElevationUV;

uniform vec2 cellIndex;

uniform sampler2D uAlbedoTexture;
uniform sampler2D uElevationTexture;

void main() 
{
    gl_FragColor = texture2D(uElevationTexture, vElevationUV);
}
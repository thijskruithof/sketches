precision mediump float;

varying vec2 vTexCoord;

uniform vec2 cellIndex;

uniform sampler2D texAlbedo;

void main() 
{
    vec2 uv = vTexCoord;

    gl_FragColor = texture2D(texAlbedo, uv);
}
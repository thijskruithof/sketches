attribute vec3 aPosition;
attribute vec2 aTexCoord;

uniform vec2 uScreenOffset;

varying vec2 vUV;
varying vec3 vPositionView;

void main() 
{
    gl_Position = vec4(aPosition.x+uScreenOffset.x, aPosition.y+uScreenOffset.y, 0.0, 1.0);

    vUV.x = aTexCoord.x * 0.5 + 0.25;
    vUV.y = aTexCoord.y * 0.5 + 0.25;
    vPositionView = vec3(aPosition.x+uScreenOffset.x, aPosition.y+uScreenOffset.y, -0.1);
}

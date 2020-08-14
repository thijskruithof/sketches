precision mediump float;

varying vec2 vTexCoord;


void main() 
{
    vec2 coord = vTexCoord;

    vec3 color1 = vec3(0.9, 0.1, 0.8); // magenta
    vec3 color2 = vec3(0.1, 0.8, 0.9); // cyan

    float mask = coord.x;

    vec3 gradient = mix(color1, color2, mask);

    gl_FragColor = vec4(gradient, 1.0 );
}
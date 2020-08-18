precision mediump float;

varying vec2 vUV;
varying vec3 vPositionView;

uniform sampler2D uTilesTexture;
uniform float uReliefDepth;

float find_intersection(vec2 dp, vec2 ds) 
{
	const int linear_steps = 32;
	const int binary_steps = 16;
	float depth_step = 1.0 / float(linear_steps);
	float size = depth_step;
	float depth = 1.0;
	float best_depth = 1.0;
	for (int i = 0 ; i < linear_steps - 1 ; ++i) 
    {
		depth -= size;
		float t = texture2D(uTilesTexture, dp + ds * depth).w;
		if (depth >= 1.0 - t)
			best_depth = depth;
	}
	depth = best_depth - size;
	for (int i = 0 ; i < binary_steps ; ++i) 
    {
		size *= 0.5;
		float t = texture2D(uTilesTexture, dp + ds * depth).w;
		if (depth >= 1.0 - t) 
        {
			best_depth = depth;
			depth -= 2.0 * size;
		}
		depth += size;
	}
	return best_depth;
}


void main() 
{
    vec3 N = vec3(0.0, 0.0, 1.0);
    vec3 etangent = vec3(1.0, 0.0, 0.0);
    vec3 ebitangent = vec3(0.0, 1.0, 0.0);

	// e: eye space
	// t: tangent space
	vec3 eview = normalize(vPositionView.xyz);
	vec3 tview = normalize(vec3(dot(eview, etangent), dot(eview, ebitangent), dot(eview, -N)));
	vec2 ds = tview.xy * uReliefDepth / tview.z;
	float dist = find_intersection(vUV, ds);
	vec2 uv = vUV + dist * ds;

    gl_FragColor = vec4(texture2D(uTilesTexture, uv).xyz, 1.0);
}
precision mediump float;

// varying vec2 vAlbedoUV;
// varying vec2 vElevationUV;
varying vec2 vUV;
varying vec3 vPositionView;
varying vec3 vEyeGroundNormal;
varying vec3 vEyeGroundTangent;
varying vec3 vEyeGroundBitangent;

uniform float uReliefDepth;

uniform sampler2D uAlbedoTexture00;
uniform sampler2D uAlbedoTexture01;
uniform sampler2D uAlbedoTexture10;
uniform sampler2D uAlbedoTexture11;
uniform sampler2D uElevationTexture00;
uniform sampler2D uElevationTexture01;
uniform sampler2D uElevationTexture10;
uniform sampler2D uElevationTexture11;



uniform vec2 uAlbedoTextureTopLeft;
uniform vec2 uAlbedoTextureSize;
uniform vec2 uElevationTextureTopLeft;
uniform vec2 uElevationTextureSize;


float sampleElevation3x3(vec2 uv)
{
    // Top?
    if (uv.y < 0.0)
    {
        if (uv.x < 0.0)
            return texture2D(uElevationTexture11, uv + vec2(1.0,1.0)).r;            
        else if (uv.x >= 1.0)
            return texture2D(uElevationTexture11, uv + vec2(-1.0,1.0)).r;
        else 
            return texture2D(uElevationTexture10, uv + vec2(0.0,1.0)).r;
    }
    // Bottom?
    else if (uv.y >= 1.0)
    {
        if (uv.x < 0.0)
            return texture2D(uElevationTexture11, uv + vec2(1.0,-1.0)).r;            
        else if (uv.x >= 1.0)
            return texture2D(uElevationTexture11, uv + vec2(-1.0,-1.0)).r;
        else 
            return texture2D(uElevationTexture10, uv + vec2(0.0,-1.0)).r;        
    }    
    // Middle?
    else
    {
        if (uv.x < 0.0)
            return texture2D(uElevationTexture01, uv + vec2(1.0,0.0)).r;            
        else if (uv.x >= 1.0)
            return texture2D(uElevationTexture01, uv + vec2(-1.0,0.0)).r;
        else 
            return texture2D(uElevationTexture00, uv + vec2(0.0,0.0)).r;        
    }
}


vec3 sampleAlbedo3x3(vec2 uv)
{
    // Top?
    if (uv.y < 0.0)
    {
        if (uv.x < 0.0)
            return texture2D(uAlbedoTexture11, uv + vec2(1.0,1.0)).xyz;            
        else if (uv.x >= 1.0)
            return texture2D(uAlbedoTexture11, uv + vec2(-1.0,1.0)).xyz;
        else 
            return texture2D(uAlbedoTexture10, uv + vec2(0.0,1.0)).xyz;
    }
    // Bottom?
    else if (uv.y >= 1.0)
    {
        if (uv.x < 0.0)
            return texture2D(uAlbedoTexture11, uv + vec2(1.0,-1.0)).xyz;            
        else if (uv.x >= 1.0)
            return texture2D(uAlbedoTexture11, uv + vec2(-1.0,-1.0)).xyz;
        else 
            return texture2D(uAlbedoTexture10, uv + vec2(0.0,-1.0)).xyz;        
    }    
    // Middle?
    else
    {
        if (uv.x < 0.0)
            return texture2D(uAlbedoTexture01, uv + vec2(1.0,0.0)).xyz;            
        else if (uv.x >= 1.0)
            return texture2D(uAlbedoTexture01, uv + vec2(-1.0,0.0)).xyz;
        else 
            return texture2D(uAlbedoTexture00, uv + vec2(0.0,0.0)).xyz;        
    }
}


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
        vec2 uv = dp + ds * depth;
		float t = sampleElevation3x3(uv);
		if (depth >= 1.0 - t)
			best_depth = depth;
	}
	depth = best_depth - size;
	for (int i = 0 ; i < binary_steps ; ++i) 
    {
		size *= 0.5;
        vec2 uv = dp + ds * depth;
		float t = sampleElevation3x3(uv);
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
    // e: eye space
	// t: tangent space
	vec3 eview = normalize(vPositionView.xyz);
	vec3 tview = normalize(vec3(dot(eview, normalize(vEyeGroundTangent)), dot(eview, normalize(vEyeGroundBitangent)), dot(eview, -normalize(vEyeGroundNormal))));
	vec2 ds = tview.xy * uReliefDepth / tview.z;
	float dist = find_intersection(vUV, ds);
	vec2 uv = vUV + dist * ds;

    uv = uAlbedoTextureTopLeft + uv * uAlbedoTextureSize;

    //gl_FragColor = vec4(texture2D(uAlbedoTexture, vAlbedoUV).xyz, texture2D(uElevationTexture, vElevationUV).x);
    gl_FragColor = vec4(sampleAlbedo3x3(uv), 1.0);

    // if (uv.x > 1.0)
    //     gl_FragColor.r = 1.0;
    // float k = sampleElevation(uv);
    // gl_FragColor = vec4(sampleAlbedo3x3(uv), 1.0);
}
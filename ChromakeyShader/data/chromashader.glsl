/* 	Chromakey Shader

	Blur implementation doesn't work yet. 
	Problem is to have two textures.
	
	source: Shadertoy - Chroma Key - Zavie 28-05-2013
			https://www.shadertoy.com/view/4dX3WN
			
			Shadertoy - Vlahos Chroma Key - Casty 17-01-2014
			// https://www.shadertoy.com/view/MsS3DW#

	adapted and combined by Kasper Kamperman for Processing.

	sources used:
	http://forum.processing.org/two/discussion/3250/how-to-store-information-in-the-alpha-channel
	https://processing.org/tutorials/pshader/
	https://github.com/SableRaf/Filters4Processing

	It would be nice to implement blur, however I don't know if that is possible in one step. 
	Otherwise we would have to create a mask first, blur it and apply it. 
	See examples > Topics > Shaders > ImageMask also blur and more.
	https://www.shadertoy.com/view/lt23DR#
	http://xissburg.com/faster-gaussian-blur-in-glsl/

	Copyleft kasperkamperman.com - 08-06-2015
*/

#ifdef GL_ES
//precision highp float;
precision mediump float;
#endif

#define PROCESSING_TEXTURE_SHADER

// Texture shaders require these standard uniforms. The filter() function in the sketch 
// will pass everything that has been drawn on the screen via the 'texture' uniform. 
uniform sampler2D texture;
uniform sampler2D textureAlpha;
uniform vec2 texOffset;
uniform mat4 texMatrix;

varying vec4 vertColor;
varying vec4 vertTexCoord;

// Parameters

uniform vec3 keyColor;
//uniform bool despill;

// The st factor takes into account the situation when non-pot
// textures are not supported, so that the maximum texture
// coordinate to cover the entire image might not be 1.
//vec2 stFactor = vec2(1.0 / abs(texMatrix[0][0]), 1.0 / abs(texMatrix[1][1]));  

//vec2 p = vec2(1.0 / abs(texMatrix[1][1]), 1.0 / abs(texMatrix[0][0]));  

vec2 p = vec2(1.0 / 640.0, 1.0 / 360.0);

vec3 rgb2hsv(vec3 rgb)
{
	float Cmax = max(rgb.r, max(rgb.g, rgb.b));
	float Cmin = min(rgb.r, min(rgb.g, rgb.b));
    float delta = Cmax - Cmin;

	vec3 hsv = vec3(0., 0., Cmax);
	
	if (Cmax > Cmin)
	{
		hsv.y = delta / Cmax;

		if (rgb.r == Cmax)
			hsv.x = (rgb.g - rgb.b) / delta;
		else
		{
			if (rgb.g == Cmax)
				hsv.x = 2. + (rgb.b - rgb.r) / delta;
			else
				hsv.x = 4. + (rgb.r - rgb.g) / delta;
		}
		hsv.x = fract(hsv.x / 6.);
	}
	return hsv;
}

float chromaKey(vec3 color)
{
	vec3 weights = vec3(4., 1., 2.);

	vec3 hsv = rgb2hsv(color);
	vec3 target = rgb2hsv(keyColor);
	float dist = length(weights * (target - hsv));
	return clamp(3. * dist - 1.5, 0., 1.);
}

// https://www.shadertoy.com/view/MsS3DW#
/*
vec4 despill(vec4 c)
{
	/// Second Vlahos assumption: max (Gf - Bf,0) <= max(Bf - Rf, 0)
	float sub = max(c.g - mix(c.b, c.r, 0.45), 0.0);
	c.g -= sub;
	
	/// 
	c.a -= smoothstep(0.25, 0.5, sub*c.a);
	
	//restore luminance (kind of, I slightly reduced the green weight)
	float luma = dot(c.rgb, vec3(0.350, 0.587,0.164));
	c.r += sub*c.r*2.0*.350/luma;
	c.g += sub*c.g*2.0*.587/luma;
	c.b += sub*c.b*2.0*.164/luma;

	return c;
}
*/

// deze blurred nu te veel, die p-factor is ook belangrijk. 

vec4 blur(vec2 uv, float scale)
{
    vec4 Color = vec4(0.0);

    // Horizontal Blur
    Color += texture2D(texture, (vec2(uv.x - 7.0 * scale * p.x, uv.y))) * 0.0044299121055113265;
	Color += texture2D(texture, (vec2(uv.x - 6.0 * scale * p.x, uv.y))) * 0.00895781211794;
	Color += texture2D(texture, (vec2(uv.x - 5.0 * scale * p.x, uv.y))) * 0.0215963866053;
	Color += texture2D(texture, (vec2(uv.x - 4.0 * scale * p.x, uv.y))) * 0.0443683338718;
	Color += texture2D(texture, (vec2(uv.x - 3.0 * scale * p.x, uv.y))) * 0.0776744219933;
	Color += texture2D(texture, (vec2(uv.x - 2.0 * scale * p.x, uv.y))) * 0.115876621105;
	Color += texture2D(texture, (vec2(uv.x - 1.0 * scale * p.x, uv.y))) * 0.147308056121;
	Color += texture2D(texture, uv) * 0.159576912161;
	Color += texture2D(texture, (vec2(uv.x + 1.0 * scale * p.x, uv.y))) * 0.147308056121;
	Color += texture2D(texture, (vec2(uv.x + 2.0 * scale * p.x, uv.y))) * 0.115876621105;
	Color += texture2D(texture, (vec2(uv.x + 3.0 * scale * p.x, uv.y))) * 0.0776744219933;
	Color += texture2D(texture, (vec2(uv.x + 4.0 * scale * p.x, uv.y))) * 0.0443683338718;
	Color += texture2D(texture, (vec2(uv.x + 5.0 * scale * p.x, uv.y))) * 0.0215963866053;
	Color += texture2D(texture, (vec2(uv.x + 6.0 * scale * p.x, uv.y))) * 0.00895781211794;
	Color += texture2D(texture, (vec2(uv.x + 7.0 * scale * p.x, uv.y))) * 0.0044299121055113265;
    
    // Vertical Blur
    
    Color += texture2D(texture, (vec2(uv.x, uv.y - 7.0 * scale * p.y))) * 0.0044299121055113265;
	Color += texture2D(texture, (vec2(uv.x, uv.y - 6.0 * scale * p.y))) * 0.00895781211794;
	Color += texture2D(texture, (vec2(uv.x, uv.y - 5.0 * scale * p.y))) * 0.0215963866053;
	Color += texture2D(texture, (vec2(uv.x, uv.y - 4.0 * scale * p.y))) * 0.0443683338718;
	Color += texture2D(texture, (vec2(uv.x, uv.y - 3.0 * scale * p.y))) * 0.0776744219933;
	Color += texture2D(texture, (vec2(uv.x, uv.y - 2.0 * scale * p.y))) * 0.115876621105;
	Color += texture2D(texture, (vec2(uv.x, uv.y - 1.0 * scale * p.y))) * 0.147308056121;
	Color += texture2D(texture, uv) * 0.159576912161;
	Color += texture2D(texture, (vec2(uv.x, uv.y + 1.0 * scale * p.y))) * 0.147308056121;
	Color += texture2D(texture, (vec2(uv.x, uv.y + 2.0 * scale * p.y))) * 0.115876621105;
	Color += texture2D(texture, (vec2(uv.x, uv.y + 3.0 * scale * p.y))) * 0.0776744219933;
	Color += texture2D(texture, (vec2(uv.x, uv.y + 4.0 * scale * p.y))) * 0.0443683338718;
	Color += texture2D(texture, (vec2(uv.x, uv.y + 5.0 * scale * p.y))) * 0.0215963866053;
	Color += texture2D(texture, (vec2(uv.x, uv.y + 6.0 * scale * p.y))) * 0.00895781211794;
	Color += texture2D(texture, (vec2(uv.x, uv.y + 7.0 * scale * p.y))) * 0.0044299121055113265;
	
	return Color/2.0;
}

void main(void)
{
	
	vec2 coord = vertTexCoord.st;
	vec4 pixel = texture2D( texture, coord);

	//textureAlpha = texture2D( texture, coord);

	vec3 color = pixel.rgb;

	float alpha = chromaKey(color);	
	
	vec4 result = vec4(color, alpha);

	//vec4 blurredResult = blur(coord, 1.0);


	//remove despill
	//if(despill) result = despill(result);

	//gl_FragColor = blurredResult;
	gl_FragColor = result;

}



/*





*/
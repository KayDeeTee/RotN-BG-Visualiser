shader_type canvas_item;

uniform sampler2D mask_tex : filter_linear,hint_default_white, repeat_enable;
uniform sampler2D mask_tex2 : filter_linear,hint_default_white, repeat_enable;
uniform sampler2D mask_tex3 : filter_linear,hint_default_white, repeat_enable;
uniform float mask_scroll_speed : hint_range(0.0, 1.0, 0.1);

uniform sampler2D cover : filter_linear,hint_default_white,repeat_enable;

uniform vec4 base_colour : source_color;
uniform vec4 dark_colour : source_color;

uniform float current_time : hint_range( 0.0, 5.0, 0.01 );

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if( UV.x < 0.5 ) {
		vec2 uv = UV;
		uv.x *= 1280.0/720.0;
		float scale = 1.0-(1.0-uv.x) * 0.5;
		scale *= scale;
		uv.y = ((uv.y-0.5)*scale)+0.5;
		COLOR = texture( cover, uv + vec2(current_time*mask_scroll_speed, 0) );
	} else {
		vec2 uv = UV;
		uv.x = 1.0-uv.x;
		uv.x *= 1280.0/720.0;
		uv.x = 1.0-uv.x;
		float scale = 1.0-(uv.x) * 0.5;
		scale *= scale;
		uv.y = ((uv.y-0.5)*scale)+0.5;
		COLOR = texture( cover, uv - vec2(current_time*mask_scroll_speed, 0) );
	}
	COLOR = mix( COLOR, base_colour, 0.5 );
	float mask2 = texture( mask_tex2, UV - vec2(0, current_time * mask_scroll_speed) ).a;
	COLOR = mix( COLOR, vec4(1.0,1.0,1.0,1.0), mask2 * 0.1 );
	float mask = texture( mask_tex, UV - vec2(0, current_time * mask_scroll_speed) ).a;
	COLOR = mix( COLOR, mix(dark_colour, base_colour, UV.y) , mask );

	float mask3a = texture( mask_tex3, UV - vec2(0, current_time * mask_scroll_speed) ).a;
	float mask3w = texture( mask_tex3, UV - vec2(0, current_time * mask_scroll_speed) ).r ;

	float percent = mod( current_time * mask_scroll_speed, 1.0 );
	float dist = abs(mask3w - percent);
	if( dist > 0.5 ){
		dist = 1.0-dist;
	}
	if( dist > 0.45 && dist < 0.55 ){
		dist = 1.0;
	} else {
		dist = 0.0;
	}
	//dist = 1.0-step( 0.995, dist );
	//if( mask3w < percent ){ dist = 1.0; }
	//if( mask3w < percent-0.05 ){ dist = 0.0; }
	//if( mask3w < 0.05 ){ 
	//	dist = 0.0;
	//}

	float brightness = 1.0;
	if( percent > 0.9 ){ brightness = 1.0 - (percent-0.9) * 1.0; }
	if( percent < 0.1 ){ brightness = 1.0 - (percent) * 1.0; }
	brightness *= 0.5;
	COLOR = mix( COLOR, vec4(1,1,1,1), mask3a * dist * brightness );

	COLOR = mix( COLOR, vec4(1.0,1.0,1.0, 1.0 ), UV.y * 0.1 );

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

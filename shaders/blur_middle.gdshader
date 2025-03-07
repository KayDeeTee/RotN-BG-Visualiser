shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform float blur_radius : hint_range(0, 1) = 0.2; // Radius of the blur effect
uniform float blur_amount : hint_range(0, 5) = 1.0; // Strength of the blur effect
uniform float blur_inner : hint_range(0, 1) = 0.6; // Inner edge of the blur effect
uniform float blur_outer : hint_range(0, 1) = 0.66; // Outer edge of the blur effect

void fragment() {
    // Original color of the pixel from the screen
	vec2 uv = SCREEN_UV;
	float d = distance( uv.x, 0.5 )*2.0;
	d = 1.0-d;
       // Original color of the pixel from the screen
    vec4 pixelColor = texture(screen_texture, UV);
    // Color with blur effect from the screen
    vec4 blurColor = textureLod(screen_texture, SCREEN_UV, blur_amount);
	float blur = smoothstep(blur_inner - blur_radius, blur_outer, d);
	pixelColor.rgb = mix(blurColor.rgb, COLOR.rgb, -blur);

 	blurColor.a = blur;
 	blurColor.rgb = mix(blurColor.rgb, vec3(1.0), 0.1);

    // Set the final color to the modified color of the blur effect
    COLOR = blurColor;
}
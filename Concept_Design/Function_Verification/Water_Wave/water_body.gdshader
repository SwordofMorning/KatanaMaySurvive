shader_type canvas_item;

uniform vec4 tint : source_color = vec4(1.0);
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Param 3 blur
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, 3);
	
	color = mix(color, tint, 0.4);
	color = mix(vec4(0.5), color, 1.4);
	
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

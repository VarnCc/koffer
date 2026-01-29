shader_type canvas_item;

uniform float power : hint_range(0.0, 1.0) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 m = texture(TEXTURE, UV);
	
	float visible = 0.0;
	
	if (m.a > 0.01 && UV.x <= power) {
		visible = 1.0;
	}
	
	vec3 col = mix(vec3(0.0, 1.0, 0.0), vec3(1.0, 0.0, 0.0), UV.x);
	
	COLOR = vec4(col * visible, m.a * visible);
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

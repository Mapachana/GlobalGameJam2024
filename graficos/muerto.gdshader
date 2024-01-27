shader_type canvas_item;

uniform float vida;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = texture(TEXTURE, UV);
	// COLOR.r=sin(TIME*2.0);
	
	//if(UV.y<vida){
		float gris=(COLOR.r+COLOR.g+COLOR.b)/3.0;
		COLOR.r=COLOR.r+abs(sin(TIME*2.0));
	//} 
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}

extends Node2D


@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var json_data = json.new("res://")

func _ready() -> void:
	#load_json_and_reset()
	pass

	
func load_json_and_reset():
	json_data.read_file("data")
	
	set_animation_from_json()
	
func set_animation_from_json():
	var animation_data = json_data.getKey("animation",{})
	var full_spritesheet: Texture2D
	var sprite_size = Vector2(animation_data.frame_w,animation_data.frame_h)
	var sprite_frames = SpriteFrames.new()
	
	for anim in animation_data.animations:
		
		if sprite_frames.has_animation(anim.name):
			continue
		sprite_frames.add_animation(anim.name)
		sprite_frames.set_animation_speed(anim.name, anim.fps)

		full_spritesheet = load(anim.filename)
		
		for y_coords in range(anim.num_frames_y):
			for x_coords in range(anim.num_frames_x):
				var frame_tex = AtlasTexture.new()
				frame_tex.atlas = full_spritesheet
				frame_tex.region = Rect2(Vector2(x_coords,y_coords)*sprite_size,sprite_size)
				sprite_frames.add_frame(anim.name,frame_tex)
		animated_sprite.sprite_frames = sprite_frames
		animated_sprite.play(anim.name)
	
	
	
	

extends TextureButton

export(int, "Phase 1", "Phase 2","Phase 3","Phase 4") var phase_number = 0

var textures = [
	{
		normal = "res://sprites/Menu/memoryRoom_level0.png",
		hover = "res://sprites/Menu/memoryRoom_hover_level0.png"
	},
	{
		normal = "res://sprites/Menu/memoryRoom_level1.png",
		hover = "res://sprites/Menu/memoryRoom_hover_level1.png"
	},
	{
		normal = "res://sprites/Menu/memoryRoom_level2.png",
		hover = "res://sprites/Menu/memoryRoom_hover_level2.png"
	},
	{
		normal = "res://sprites/Menu/memoryRoom_level3.png",
		hover = "res://sprites/Menu/memoryRoom_hover_level3.png"
	}
]

var block_texture = "res://sprites/Menu/memoryRoom_levelLock.png"

var is_active = false

func _ready():
	texture_normal = load(block_texture)
	texture_hover = load(block_texture) 
	if GAME.total_open_scennes >= phase_number:
		is_active = true
		texture_normal = load(textures[phase_number].normal)
		texture_hover = load(textures[phase_number].hover) 
		

func _on_BtnPhase_pressed():
	if is_active:
		GAME.set_phase(phase_number)

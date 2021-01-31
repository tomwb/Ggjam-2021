tool
extends Area2D

export(String, "a", "u", "g", "uu", "s", "t", "e") var letter = "a" setget set_letter

func _ready():
	pass
	
func _draw():
	var tmp_letter = letter
	if letter == "uu":
		tmp_letter = "u"
	$AnimatedSprite.play(tmp_letter)
		
func set_letter(value):
	letter = value
	if is_inside_tree() && Engine.editor_hint:
		update()

func _on_Letter_area_entered(area):
	$AnimatedSprite.play("collected")
	yield($AnimatedSprite, "animation_finished")
	HUD.set_letter(letter)
	queue_free()

tool
extends Area2D

export(String, "a", "u", "g", "s", "t", "e") var letter = "a" setget set_letter

func _ready():
	pass
	
func _draw():
	$AnimatedSprite.play(letter)
		
func set_letter(value):
	letter = value
	if is_inside_tree() && Engine.editor_hint:
		update()

func _on_Letter_area_entered(area):
	$AnimatedSprite.play("collected")
	yield($AnimatedSprite, "animation_finished")
	queue_free()

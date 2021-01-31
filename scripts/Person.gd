tool
extends Area2D

var is_active = true

var people = [
	{
		sprite = "res://sprites/phase4/level4_people2_1.png",
		text= ["Hey neighbor !!! I was worried about you! Glad you are recovering the memories!"]
	},
	{
		sprite = "res://sprites/phase4/level4_people2_2.png",
		text= ["Oh My brother! This disease is terrible! Glad you remembered us!"]
	},
	{
		sprite = "res://sprites/phase4/level4_people2_3.png",
		text= ["Hey man! I miss our college days, do we still look young like that time?"]
	},
	{
		sprite = "res://sprites/phase4/level4_people2_4.png",
		text= ["Face it Lion! You Just won the bingo!"]
	},
	{
		sprite = "res://sprites/phase4/level4_people2_5.png",
		text= ["Dad, you must come back to us! Please don't forget us! Don't Let the Disease win!"]
	},
	{
		sprite = "res://sprites/phase4/level4_people2_6.png",
		text= ["if you take your medicine right, you will be capable to recover some memories! and they Will control your symptoms"]
	},
	{
		sprite = "res://sprites/phase4/level4_people2_7.png",
		text= ["Stop wasting time, get back in the game! I'm just the programmer, don't mind me, you have important people to come back to!"]
	}
]

export(int, "Terry Crews", "Oraculo", "Hipster", "Patroa", "Catarrento", "Thais Araujo", "Tom") var person = 0 setget set_person

func _ready():
	pass

func _draw():
	$Sprite.texture = load(people[person].sprite)
		
func set_person(value):
	person = value
	if is_inside_tree() && Engine.editor_hint:
		update()
	
func _on_Person_area_entered(area):
	if is_active && person <= people.size(): 
		HUD.showTextModal('person', people[person].text)
		is_active = false
		
		

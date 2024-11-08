extends Node2D
class_name RuneIconFlasher

@onready var sprite:Sprite2D = $Sprite2D
@onready var text_container:Control = $Text
@onready var anim:AnimationPlayer = $AnimationPlayer

func flash_spell(spell:Spell):
	text_container.get_node("Label").text = spell.name
	sprite.texture = spell.icon
	anim.play("flash")

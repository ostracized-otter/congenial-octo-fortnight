extends CharacterBody2D
@export var talk_label: Node

func talk():
	talk_label.text = "fotsdf"
	await get_tree().create_timer(3).timeout
	talk_label.text = ""

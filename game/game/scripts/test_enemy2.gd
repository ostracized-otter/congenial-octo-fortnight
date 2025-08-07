extends CharacterBody2D

@export var player: Node2D
@export var speed = 180
@onready var global = get_node("/root/Global")

func _physics_process(delta: float) -> void:
	if global.enemy_can_move:
		var target = player.position
		velocity = position.direction_to(target) * speed
		look_at(target)
		
		move_and_slide()
		
func touch():
	print("skibidi")

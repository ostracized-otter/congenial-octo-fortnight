extends CharacterBody2D
var last_direction = ""
@export var speed = 400
@onready var global = get_node("/root/Global")
var tile_size = 40
var can_move = true
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}
			
func _ready():
	#position = position.snapped(Vector2.ONE * tile_size)
	#position += Vector2.ONE * tile_size/2
	pass
	
func _unhandled_input(event):
	for dir in inputs.keys():
		if can_move:
			if event.is_action_pressed(dir):
				move(dir)
				global.enemy_can_move = true
				#update(dir)
			
func _process(delta: float):
		for dir in inputs.keys():
			if Input.is_action_pressed(dir):
				update(dir)

func check_input():
	if Input.is_action_pressed(last_direction):
		move(last_direction)
		global.enemy_can_move = true
	can_move = true

func move(dir):
	position += inputs[dir] * tile_size
	$Timer.start(0.4)
	can_move = false
	
func update(dir):
	last_direction = dir
	
	
	
func get_input():
	
	if Input.is_action_pressed("func_attack"):
		$Area2D/CollisionShape2D.set_deferred("disabled", false)
		await get_tree().create_timer(0.1).timeout
		$Area2D/CollisionShape2D.set_deferred("disabled", true)


func _physics_process(delta):
	get_input()
	move_and_slide()

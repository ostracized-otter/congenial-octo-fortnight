extends CharacterBody2D
var last_direction = ""
@export var speed = 400
@export var talk_label: Node
@onready var global = get_node("/root/Global")
var tile_size = 40
var can_move = true
var combat = false
var combat_run = false
var can_rotate = true
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
			if combat == false:
				if event.is_action_pressed(dir):
					if $Node2D/Area2D/RayCast2D.is_colliding() == false:
						move(dir)
						global.enemy_can_move = true
						print("sides colliding")
					elif $Node2D/Area2D/RayCast2D.is_colliding():
						print("Front colliding")
						pass
					elif $Node2D/Area2D/RayCast2D.is_colliding() and $Node2D/Area2D/RayCast2Dl.is_colliding():
						move(dir)
						print("One side")
						global.enemy_can_move = true
					elif $Node2D/Area2D/RayCast2D.is_colliding() and $Node2D/Area2D/RayCast2Dr.is_colliding():
						move(dir)
						print("Other side")
						global.enemy_can_move = true
		

		
func _process(delta: float):

	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			update(dir)
	
			

func check_input():
	print(last_direction)
	can_move = true

	if Input.is_action_pressed(last_direction):
		if $Node2D/Area2D/RayCast2D.is_colliding() == false:
			move(last_direction)
			global.enemy_can_move = true

func move(dir):
	if can_move:
		
		var tween = get_tree().create_tween()
		#can_rotate == false
		#print("rotate off")
		tween.tween_property(self, "position", position + inputs[dir]*tile_size, 0.2)
		#tween.tween_property(self, "scale", Vector2(), 1)

		tween.tween_callback(check_input)
		
		#position += inputs[dir] * tile_size

		can_move = false
	
func update(dir):
#6,7!!
	last_direction = dir
	#if $Node2D/Area2D/RayCast2Dr.is_colliding() == false:
		#dir == "ui_up" #change to last dir
	#if $Node2D/Area2D/RayCast2Dl.is_colliding() == false:
		#dir == "ui_up"
		#$Timer.start(0.4)
	
	if can_rotate == true:
		if dir == "ui_right":
			$Node2D.rotation=deg_to_rad(90)
		elif dir == "ui_left":
			$Node2D.rotation=deg_to_rad(270)
		elif dir == "ui_up":
			$Node2D.rotation=deg_to_rad(0)
		elif dir == "ui_down":
			$Node2D.rotation=deg_to_rad(180)


func talk():
	talk_label.text = str(global.enemy_can_move)

	

	
func get_input():
	
	if Input.is_action_pressed("rotate"):
		can_move=false
	elif Input.is_action_just_released("rotate"):
		can_move=true
	if Input.is_action_pressed("func_attack"):
		$Node2D/Area2D/CollisionShape2D.set_deferred("disabled", false)
		await get_tree().create_timer(0.1).timeout
		$Node2D/Area2D/CollisionShape2D.set_deferred("disabled", true)
	talk()

	

		
func _physics_process(delta):
	get_input()
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("friendlies"):
		body.talk()

		
func _on_area_2d_body_touched(body: Node2D) -> void:
		if body.is_in_group("baddies"):
			if combat_run == false: # Replace with function body.
				body.touch()
				combat=true
				global.enemy_can_move = true
				combat_run = true
				print("move:no")

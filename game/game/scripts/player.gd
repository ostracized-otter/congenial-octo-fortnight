extends CharacterBody2D
var last_direction = ""
@export var speed = 200
@export var talk_label: Node
@onready var global = get_node("/root/Global")
@onready var animation_player = $AnimationPlayer
var tile_size = 40
var can_move = true
var combat = false
var combat_run = false
var can_rotate = true
			
func _ready():
	pass
	
func _unhandled_input(event):
		if can_move:
			if combat == false:
				$AnimationPlayer.play("casual")
					
func _process(delta: float):
	pass

func get_input():
	if Input.is_action_pressed("func_attack"):
		$Node2D/Area2D/CollisionShape2D.set_deferred("disabled", false)
		await get_tree().create_timer(0.1).timeout
		$Node2D/Area2D/CollisionShape2D.set_deferred("disabled", true)


func _physics_process(delta):
	# six seven !!!!!!!
	if can_move:
		var input_dir = Input.get_vector("left", "right", "up", "down")
		velocity = input_dir * speed
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
			#global.enemy_can_move = true
			combat_run = true
			print("move:no")
			talk_label.text = "you fuking dead cunt"
			await get_tree().create_timer(1).timeout
			global.enemy_can_move = false
			get_tree().reload_current_scene()

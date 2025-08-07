extends CharacterBody2D
var player: Node
var dirx  = 0
var diry = 0
var health: float = 3
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
var tile_size = 40
@export var enemyturn = false
@onready var global = get_node("/root/Global")

var speed: float = 40

func _ready() -> void:
	for players in get_tree().get_nodes_in_group("player"):
		player = players

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(player.position)
func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

#
#func _physics_process(delta: float) -> void:
	#_move_towards_player()

func _move_towards_player():
	pass
func _process(delta: float):
	if not player == null:
		#look_at(player.global_position)
		#velocity = Vector2(1, 0).rotated(rotation) * speed
		#move_and_slide()
		pass

	if global.enemy_can_move == true:
		
		#var direction = (player.global_position - global_position)
		#print(direction.x)
		#print(direction.y)
		#if direction.x < -1:
			#dirx = -40
			#$Node2D.rotation=deg_to_rad(270)
			#
		#if direction.x > 1:
			#dirx = 40
			#$Node2D.rotation=deg_to_rad(90)
			#
		#if direction.y < -1:
			#diry = -40
			#$Node2D.rotation=deg_to_rad(0)
			#
		#if direction.y > 1:
			#diry = 40
			#$Node2D.rotation=deg_to_rad(180)
			#
		#elif direction.y > -20 and direction.y < 20:
			#diry = 0
		#
		#elif direction.x > -20 and direction.x < 20:
			#dirx = 0
		print(dirx, "enehy")
		print(diry, "enemy2")
		var tween = get_tree().create_tween()
		##position = position.snapped(Vector2.ONE * tile_size)
		#if $Node2D/Area2D/RayCast2D.is_colliding() == false:
			#if $Node2D/Area2D/RayCast2D2.is_colliding() == false:
				#if $Node2D/Area2D/RayCast2D3.is_colliding() == false:
					#tween.tween_property(self, "position", Vector2(position.x+dirx, position.y+diry), 0.2)
		
		set_movement_target(player.position)
		var target = navigation_agent.get_next_path_position()
		if target.x - position.x< -10:
			dirx = -40
			$Node2D.rotation=deg_to_rad(270)
			
		if target.x - position.x > 10:
			dirx = 40
			$Node2D.rotation=deg_to_rad(90)
			
		if target.y - position.y < -10:
			diry = -40
			$Node2D.rotation=deg_to_rad(0)
			
		if target.y - position.y> 10:
			diry = 40
			$Node2D.rotation=deg_to_rad(180)
			
		#elif player.position.y > -20 and player.position.y < 20:
			#diry = 0
		#
		#elif player.position.x > -20 and player.position.x < 20:
			#dirx = 0
			
		#THIS ONE
		tween.tween_property(self, "position", Vector2(global_position.x+dirx, global_position.y+diry), 0.2)
		if navigation_agent.is_navigation_finished():
			return
		global.enemy_can_move = false

		
		
		#var current_agent_position: Vector2 = global_position
		#var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	## Calculate the new velocity
		#var new_velocity = current_agent_position.direction_to(next_path_position) * speed
#
	## Set correct velocity
		#if navigation_agent.avoidance_enabled:
			#navigation_agent.set_velocity(new_velocity)


	# Do the movement
	#move_and_slide()
	
		

	
			#global.enemy_can_move = false
			#Engine.time_scale = 0.1
func touch():
	print("lets have sex")

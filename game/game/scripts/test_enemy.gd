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
func _process(delta: float):
	
	if not player == null:
		#look_at(player.global_position)
		#velocity = Vector2(1, 0).rotated(rotation) * speed
		#move_and_slide()
		pass

	if global.enemy_can_move == true:

		var direction = (player.global_position - global_position)
		print(direction.x)
		print(direction.y)
		if direction.x < 0:
			dirx = -40
			$Node2D.rotation=deg_to_rad(270)
			
		if direction.x > 0:
			dirx = 40
			$Node2D.rotation=deg_to_rad(90)
			
		if direction.y < 0:
			diry = -40
			$Node2D.rotation=deg_to_rad(0)
			
		if direction.y > 0:
			diry = 40
			$Node2D.rotation=deg_to_rad(180)
			
		elif direction.y > -20 and direction.y < 20:
			diry = 0
		
		elif direction.x > -20 and direction.x < 20:
			dirx = 0
		print(dirx, "enehy")
		print(diry, "enemy2")
		var tween = get_tree().create_tween()
		#position = position.snapped(Vector2.ONE * tile_size)
		if $Node2D/Area2D/RayCast2D.is_colliding() == false:
			if $Node2D/Area2D/RayCast2D2.is_colliding() == false:
				if $Node2D/Area2D/RayCast2D3.is_colliding() == false:
					tween.tween_property(self, "position", Vector2(position.x+dirx, position.y+diry), 0.2)
		#tween.parallel().tween_property(self, "position", Vector2(position.x+dirx, position.y), 0.2)
		
	
		
		#tween.parallel().tween_property(self, "position", Vector2(position.x, position.y+diry), 0.2)
	#	position.x += dirx
		#position.y += diry
		#position += Vector2.ONE * tile_size/2
	
			global.enemy_can_move = false
			#Engine.time_scale = 0.1
func touch():
	print("lets have sex")

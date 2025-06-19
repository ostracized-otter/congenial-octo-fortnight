extends CharacterBody2D
var player: Node
var dirx  = 0
var diry = 0
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
		if direction.x <= 0:
			dirx = -40
			
		if direction.x >= 0:
			dirx = 40
			
		if direction.y <= 0:
			diry = -40
			
		if direction.y >= 0:
			diry = 40
		
		#position = position.snapped(Vector2.ONE * tile_size)
		position.x += dirx
		position.y += diry
		#position += Vector2.ONE * tile_size/2
	
		global.enemy_can_move = false

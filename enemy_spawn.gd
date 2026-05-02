extends Node2D

@export var enemy_scene : PackedScene # Drag your Enemy.tscn here
@export var spawn_delay = 5.0

# Define your map boundaries (matching your player script)
var min_x = 0
var min_y = 0
var max_x = 1224
var max_y = 696
var buffer = 32 # Spawns slightly inside the edges

@onready var spawn_timer = $Timer

func _ready():
	spawn_timer.wait_time = spawn_delay
	spawn_timer.start()

func _on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	if enemy_scene == null:
		print("ERROR: No enemy scene assigned to Spawner!")
		return 
		
	# 1. Create the enemy instance
	var enemy = enemy_scene.instantiate()
	
	# 2. Generate random coordinates within the map limits
	# We use 'buffer' so they don't spawn exactly on the pixel edge
	var rand_x = randf_range(min_x + buffer, max_x - buffer)
	var rand_y = randf_range(min_y + buffer, max_y - buffer)
	
	# 3. Set the enemy position
	enemy.global_position = Vector2(rand_x, rand_y)
	
	# 4. Add to the scene
	get_tree().current_scene.add_child(enemy)
	
	print("SUCCESS: Enemy spawned randomly at ", enemy.global_position)

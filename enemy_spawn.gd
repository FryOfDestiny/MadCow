extends Node2D

@export var enemy_scene : PackedScene 
@export var spawn_delay = 5.0 # Starting speed
@export var min_spawn_delay = 0.5 # Fastest speed possible
@export var difficulty_increase_rate = 0.04 # How much faster it gets each spawn

# Map boundaries
var min_x = 0
var min_y = 0
var max_x = 1224
var max_y = 696
var buffer = 32 

@onready var spawn_timer = $Timer

func _ready():
	spawn_timer.wait_time = spawn_delay
	spawn_timer.start()

func _on_timer_timeout():
	spawn_enemy()
	
	# Check if we are still above the minimum allowed delay
	if spawn_timer.wait_time > min_spawn_delay:
		# Use max() to ensure we never go below the min_spawn_delay
		spawn_timer.wait_time = max(min_spawn_delay, spawn_timer.wait_time - difficulty_increase_rate)
		
	# Important: Restart the timer with the NEW wait_time
	spawn_timer.start()

func spawn_enemy():
	if enemy_scene == null:
		return 
		
	var enemy = enemy_scene.instantiate()
	
	# Random spawn logic
	var rand_x = randf_range(min_x + buffer, max_x - buffer)
	var rand_y = randf_range(min_y + buffer, max_y - buffer)
	
	enemy.global_position = Vector2(rand_x, rand_y)
	get_tree().current_scene.add_child(enemy)

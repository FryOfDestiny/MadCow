
extends TextureProgressBar


var stats : Stats
var current
var next

func set_stats(s: Stats):
	stats = s
	stats.experience_changed.connect(update)
	update()


# Called when the node enters the scene tree for the first time.
func _ready():
	# Wait a frame to ensure the player exists
	await get_tree().process_frame 
	
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var s = player.get_node_or_null("Stats")
		if s:
			set_stats(s) # This connects the signals and runs update()
	if current == null:
		current = 0
		$Experience_Label.update_label()
	if stats != null:
		stats.experience_changed.connect(update)
		update()


#update healthbar
func update():
	current = stats.experience
	next = stats.experience_required
	value = current * 100 / next
	$Experience_Label.update_label()

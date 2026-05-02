extends Area2D

@export var xp_amount = 10

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player children: ", body.get_children())
		
		var stats = body.get_node_or_null("Stats") 
		
		if stats:
			print("Stats node found! Adding XP...")
			stats.add_experience(xp_amount)
			queue_free()
		else:
	
			for child in body.get_children():
				if child is Stats:
					print("Found stats by class! Adding XP...")
					child.add_experience(xp_amount)
					queue_free()
					return

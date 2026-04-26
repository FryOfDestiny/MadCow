extends Area2D

@export var xp_amount = 10

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# 1. Print all children to see what the node is actually called
		print("Player children: ", body.get_children())
		
		# 2. Try to find the stats node
		var stats = body.get_node_or_null("Stats") 
		
		if stats:
			print("Stats node found! Adding XP...")
			stats.add_experience(xp_amount)
			queue_free()
		else:
			print("ERROR: Could not find a node named 'Stats' on the player.")
			# Alternative: Try to find by class if the name is different
			for child in body.get_children():
				if child is Stats:
					print("Found stats by class! Adding XP...")
					child.add_experience(xp_amount)
					queue_free()
					return

extends TextureProgressBar

#bring player here
@export var player: Player 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#recieve update signal
	player.healthChanged.connect(update)
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#update healthbar
func update():
	value = player.currentHealth * 100 / player.maxHealth

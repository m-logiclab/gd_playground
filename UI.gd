extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_player_update_gem(jems):
	$Label.text = str(jems * 100)

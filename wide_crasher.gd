extends Node3D
@onready var holder = $Wide_Crasher_01/Wide_Crasher_01_Holder

var top_pos := Vector3( 0, 2.7, 0)
var bottom_pos := Vector3( 0, 0.7, 0)


# Called when the node enters the scene tree for the first time.
func _ready():
	holder.position = top_pos
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property( holder, "position", bottom_pos, 1 )
	tween.tween_interval( 2.0 )
	tween.tween_property( holder, "position", top_pos, 1 )
	tween.tween_interval( 2.0 )
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

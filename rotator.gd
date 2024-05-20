extends Node3D
@export var rotate_speed :float = 5.0
var rotate_object :Node3D


# さいしょによびだされる
func _ready():
	rotate_object = get_child(0)

# ずっと
func _process(delta):
	rotate_object.rotate_y( rotate_speed * delta )

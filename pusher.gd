extends Node3D
@onready var area_3d = $Pusher_01/Pusher_01_Head/Area3D
var hit_character :Node3D
var push_force :float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready():
	area_3d.body_entered.connect( func(body): hit_character = body )
	area_3d.body_exited.connect( func(_body): hit_character = null )
	

func push():
	if hit_character:
		if hit_character.has_method( "spring_force" ):
			var push_velocity = global_transform.basis.z.normalized()
			push_velocity *= push_force
			hit_character.spring_force(push_velocity)



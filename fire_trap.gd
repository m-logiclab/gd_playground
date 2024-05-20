extends Node3D
var fire_scene = preload("res://VFX/fire.tscn")
var size :int = 4
var gap :float = 0.7
var start_pos := Vector3( -1.05, 0.5, -1.05 )
var is_emitting = true
@onready var area_3d = $Area3D
var hit_character :Node3D

# Called when the node enters the scene tree for the first time.
func _ready():

	for x in range(size):
		for z in range(size):
			var new_particle = fire_scene.instantiate()
			new_particle.position = start_pos + Vector3(
				x * gap,
				0,
				z * gap
			)
			add_child(new_particle)
	
	area_3d.body_entered.connect( func(body):
		hit_character = body
		hit_check())
	area_3d.body_exited.connect( func(_body): hit_character = null)

func hit_check():
	if is_emitting and hit_character:
		if hit_character.has_method("hit_and_restart"):
			hit_character.hit_and_restart()


func _on_timer_timeout():
	is_emitting = not is_emitting
	var particles = get_tree().get_nodes_in_group("particles")
	for particle in particles:
		particle.emitting = is_emitting
	#for i in get_child_count():
		#var particle_node = get_child(i)
		#if particle_node is GPUParticles3D:
			#particle_node.emitting = is_emitting
	hit_check()

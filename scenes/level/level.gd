extends Node2D

@onready var animal_start = $AnimalStart
const ANIMAL = preload("res://scenes/animal/animal.tscn")
const MAIN = preload("res://scenes/main/main.tscn")
@onready var bg_music = $BGMusic

# Called when the node enters the scene tree for the first time.
func _ready():
	create_animal()
	SignalManager.on_animal_died.connect(create_animal)
	bg_music.play()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_packed(MAIN)
		bg_music.stop()

func create_animal() -> void:
	var new_animal = ANIMAL.instantiate()
	new_animal.position = animal_start.position
	add_child(new_animal)

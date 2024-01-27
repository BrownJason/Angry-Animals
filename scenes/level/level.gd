extends Node2D

@onready var animal_start = $AnimalStart
const ANIMAL = preload("res://scenes/animal/animal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	create_animal()
	SignalManager.on_animal_died.connect(create_animal)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_animal() -> void:
	var new_animal = ANIMAL.instantiate()
	new_animal.position = animal_start.position
	add_child(new_animal)

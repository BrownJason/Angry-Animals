extends Control

@onready var audio_stream_player = $AudioStreamPlayer
@onready var go_label = $MarginContainer/VBoxContainer2/GoLabel
const MAIN = preload("res://scenes/main/main.tscn")
@onready var level_label = $MarginContainer/VBoxContainer/LevelLabel
@onready var score_label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var v_box_container_2 = $MarginContainer/VBoxContainer2

# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = "LEVEL %s" % ScoreManager.get_level_selected()
	update_attempts(0)
	SignalManager.on_score_updated.connect(update_attempts)
	SignalManager.on_level_complete.connect(on_level_complete)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_level_complete() -> void:
	v_box_container_2.show()
	audio_stream_player.play()

func update_attempts(attempts: int) -> void:
	score_label.text = "Attempts %s" % attempts

func _input(event):
	if v_box_container_2.visible:
		if event.is_action_pressed("menu") || event is InputEventScreenTouch:
			get_tree().change_scene_to_packed(MAIN)

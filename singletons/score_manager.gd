extends Node

const DEFAULT_SCORE: int = 1000
const SCORE_PATH = "user://animals_score.save"

var _level_selected: int = 1
var _level_scores: Dictionary = {
	"1": 1000,
	"2": 1000,
	"3": 1000	
}

func _ready():
	load_file()
	AudioServer.set_bus_volume_db(0, -30)

func set_level_selected(ls: int) -> void:
	_level_selected = ls
	
func get_level_selected() -> int:
	return _level_selected

func check_and_add(level: String) -> void:
	if !_level_scores.has(level):
		_level_scores[level] = DEFAULT_SCORE
		
func set_level_scores(score: int, level: String) -> void:
	check_and_add(level)
	if _level_scores[level] > score:
		_level_scores[level] = score
		save_file()

func get_highscore_level(level: String) -> int:
	check_and_add(level)
	return _level_scores[level]

func save_file():
	var file = FileAccess.open(SCORE_PATH, FileAccess.WRITE)
	var score_json_str = JSON.stringify(_level_scores)
	file.store_string(score_json_str)
	
func load_file():
	var file = FileAccess.open(SCORE_PATH, FileAccess.READ)
	if file == null:
		save_file()
	else:
		var content = file.get_as_text()
		_level_scores = JSON.parse_string(content)

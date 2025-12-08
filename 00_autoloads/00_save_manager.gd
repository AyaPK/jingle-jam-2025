extends Node

const SAVE_PATH := "user://savegame.json"

var save_exists: bool:
	get: return FileAccess.file_exists(SAVE_PATH)

func _ready() -> void:
	if save_exists:
		load_game()

func save_game() -> void:
	var ds := {}
	for k in GameStateManager.demon_states.keys():
		ds[k] = int(GameStateManager.demon_states[k])
	var save_data := {
		"demon_states": ds,
		"inventory": _resources_to_paths(PlayerManager.inventory),
		"insults": _resources_to_paths(PlayerManager.insult_dialog_pool),
		"seductions": _resources_to_paths(PlayerManager.seduction_dialog_pool),
	}
	var json_text := JSON.stringify(save_data)
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f:
		f.store_string(json_text)
		f.close()

func load_game() -> void:
	if not save_exists:
		return
	var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not f:
		return
	var text := f.get_as_text()
	f.close()

	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		return

	if parsed.has("demon_states") and typeof(parsed.demon_states) == TYPE_DICTIONARY:
		for k in parsed.demon_states.keys():
			GameStateManager.demon_states[k] = int(parsed.demon_states[k])

	if parsed.has("inventory") and typeof(parsed.inventory) == TYPE_ARRAY:
		if PlayerManager.inventory == null:
			PlayerManager.inventory = []
		PlayerManager.inventory.clear()
		for p in parsed.inventory:
			var r := _safe_load_resource(p)
			if r != null:
				PlayerManager.inventory.append(r)

	if parsed.has("insults") and typeof(parsed.insults) == TYPE_ARRAY:
		if PlayerManager.insult_dialog_pool == null:
			PlayerManager.insult_dialog_pool = []
		PlayerManager.insult_dialog_pool.clear()
		for p in parsed.insults:
			var r := _safe_load_resource(p)
			if r != null:
				PlayerManager.insult_dialog_pool.append(r)

	if parsed.has("seductions") and typeof(parsed.seductions) == TYPE_ARRAY:
		if PlayerManager.seduction_dialog_pool == null:
			PlayerManager.seduction_dialog_pool = []
		PlayerManager.seduction_dialog_pool.clear()
		for p in parsed.seductions:
			var r := _safe_load_resource(p)
			if r != null:
				PlayerManager.seduction_dialog_pool.append(r)

func _resources_to_paths(arr: Array) -> Array:
	var out: Array = []
	if arr == null:
		return out
	for res in arr:
		if res is Resource:
			var path := (res as Resource).resource_path
			if path != "":
				out.append(path)
	return out

func _safe_load_resource(path: String) -> Resource:
	if typeof(path) != TYPE_STRING or path == "":
		return null
	var res := load(path)
	if res is Resource:
		return res
	return null


func delete_data(restart: bool = true) -> void:
	if save_exists:
		DirAccess.remove_absolute(SAVE_PATH)
	
	PlayerManager.refresh()
	GameStateManager.refresh()
	
	if restart:
		var main_scene = ProjectSettings.get_setting("application/run/main_scene")
		if typeof(main_scene) == TYPE_STRING and main_scene != "":
			get_tree().change_scene_to_file(main_scene)

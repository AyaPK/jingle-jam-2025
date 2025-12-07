class_name Dialog extends Resource

enum DIALOG_RARITY {
	COMMON,
	RARE,
	ULTRA_RARE,
}

enum DIALOG_TYPE {
	ATTACK,
	SEDUCE
}

@export_category("Config")
@export_multiline var name: String
@export_multiline var dialog_text: String
@export var rarity: DIALOG_RARITY
@export var type: DIALOG_TYPE = DIALOG_TYPE.ATTACK

@export_category("Stats")
@export var damage: int
@export var seduction: int

func get_dialog_source() -> String:
	return resource_path.split("/")[-2]

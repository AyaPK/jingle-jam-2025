class_name Dialog extends Resource

enum DIALOG_RARITY {
	COMMON,
	RARE,
	ULTRA_RARE,
}

@export_category("Config")
@export_multiline var name: String
@export_multiline var dialog_text: String
@export var rarity: DIALOG_RARITY

@export_category("Stats")
@export var damage: int
@export var seduction: int

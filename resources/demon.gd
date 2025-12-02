class_name Demon extends Resource

@export_category("Assets")
@export var image: Texture2D

@export_category("Stats")
@export var hp: int
@export var seduction_target: int

@export_category("Dialogue")
@export_multiline var entry_text: String
@export_multiline var beaten_text: String
@export_multiline var seduced_text: String
@export_multiline var lose_text: String

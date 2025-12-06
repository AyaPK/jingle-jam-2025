class_name Demon extends Resource

@export_category("Assets")
@export var full_image: Texture2D
@export var headshot: Texture2D

@export_category("Stats")
@export var demon_name: String
@export var hp: int = 100
@export var seduction_target: int = 100

@export_category("Dialogue")
@export_multiline var entry_text: String
@export_multiline var beaten_text: String
@export_multiline var seduced_text: String
@export_multiline var lose_text: String

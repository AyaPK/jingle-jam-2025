class_name BattleItemButton extends Button

var item_resource: Item

@onready var item_sprite: TextureRect = $ItemSprite
@onready var item_sprite_shadow: TextureRect = $ItemSpriteShadow

func load_item_details() -> void:
	item_sprite.texture = item_resource.image
	item_sprite_shadow.texture = item_resource.image
	text = item_resource.item_name

func _on_mouse_entered() -> void:
	grab_focus()

func _on_pressed() -> void:
	BattleManager.turn_queue.append(item_resource)
	Signals.battle_turns_started.emit()

class_name WatchItemEffect extends ItemEffect

func trigger() -> void:
	var demon = BattleManager.current_demon

	DialogPanel.push_text("You presented %s with a wristwatch" % demon.demon_name)

	if BattleManager.current_demon.internal_name in ["Greed"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("I've got a lot of watches but nothing like this", demon)
	elif BattleManager.current_demon.internal_name in ["Wrath", "Lust"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("Thanks.", demon)
	elif BattleManager.current_demon.internal_name in ["Envy", "Gluttony", "Pride"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text("I don't need this.", demon)
	elif BattleManager.current_demon.internal_name in ["Sloth"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text("Who needs to keep track of time, I just want to sleep", demon)
	

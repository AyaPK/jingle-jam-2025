extends Node

#region dialog system
signal dialog_started
signal dialog_finished
signal dialog_line_started(text: String)
#endregion

#region battle system
signal menu_state_changed(old_state: Battle.MenuState, new_state: Battle.MenuState)
signal battle_turns_started
signal battle_turns_finished
signal battle_single_turn
signal battle_player_lost
signal battle_demon_beaten
signal battle_demon_seduced
signal battle_left
signal battle_end
signal battle_options_refreshed
signal damage_dealt
signal battle_demon_seduction_dealt
signal battle_demon_insult_dealt
#endregion

#region SaveLoad System
signal game_saved
signal game_loaded
#endregion

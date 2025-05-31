extends ItemCharSetup

func first_time_setup(player: Player) -> void:
	for track in player.stats.gags_unlocked.keys():
		player.stats.gags_unlocked[track] = 7
	player.stats.luck = 1.05

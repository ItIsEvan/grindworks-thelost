extends ItemScript

var stat_mult: StatMultiplier
var laff_total: int = 0


func on_collect(_item: Item, _object: Node3D) -> void:
	setup()

func on_load(_item: Item) -> void:
	setup()

func setup() -> void:
	# Set up our stat multiplier
	stat_mult = StatMultiplier.new()
	stat_mult.additive = true
	stat_mult.stat = 'evasiveness'
	stat_mult.amount = 0.0
	
	var player: Player = Util.get_player()
	player.stats.s_defense_changed.connect(on_defense_changed)
	on_defense_changed(player.stats.defense)
	player.stats.multipliers.append(stat_mult)
	player.stats.max_hp_changed.connect(on_max_hp_changed)

func on_defense_changed(new_def: float) -> void:
	stat_mult.amount = new_def - 1.0

func on_max_hp_changed(new_hp: int) -> void:
	var player := Util.get_player()
	await get_tree().process_frame
	if not new_hp == 1:
		player.stats.max_hp = 1
		player.stats.hp = 1
		player.laff_meter.set_max_laff(1)

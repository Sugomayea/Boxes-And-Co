if obj_player.facing = 0 {
	sprite_index = spr_dialogueRight
	x = obj_player.x + 12
	y = obj_player.y
} else if obj_player.facing = 1 {
	sprite_index = spr_dialogueLeft
	x = obj_player.x - 12
	y = obj_player.y
} else if obj_player.facing = 2 {
	sprite_index = spr_dialogueUp
	x = obj_player.x
	y = obj_player.y - 8
} else if obj_player.facing = 3 {
	sprite_index = spr_dialogueDown
	x = obj_player.x
	y = obj_player.y + 12
}
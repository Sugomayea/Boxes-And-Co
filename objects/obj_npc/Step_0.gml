var _s = id

if keyboard_check_pressed(ord("E")) and place_meeting(x, y, obj_dialogueBox) and !instance_exists(obj_textbox) {
	create_textbox(text_id)
}

if y >= obj_player.y {
	depth = obj_player.depth - 100
} else if y < obj_player.y {
	depth = obj_player.depth + 100
}
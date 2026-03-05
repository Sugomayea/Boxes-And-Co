imageShi += imageSpeed

if place_meeting(x, y, obj_dialogueBox) and !instance_exists(obj_textbox) {
	promptDrawn = true
	draw_sprite(spr_ePrompt, imageShi, obj_player.x, obj_player.y - 70)
} else {
	promptDrawn = false
}
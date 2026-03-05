/// @param text_id
function scr_game_text(_text_id){
	cadeSpeaks = "Cade: "
	luciaSpeaks = "Lucia: "
	richSpeaks = "Rich: "
	mickeySpeaks = "Mickey: "
	
	switch (_text_id) {
		case "test":
			scr_text(cadeSpeaks + "Fart.", "cade")
			break
	}
}
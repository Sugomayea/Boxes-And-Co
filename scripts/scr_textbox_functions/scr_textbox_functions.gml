function scr_set_defaults_for_text() {
	line_break_pos[0, page_number] = 999
	line_break_num[page_number] = 0
	line_break_offset[page_number] = 0
	
	//variables for every letter/char
	for (var c = 0; c < 500; c++) {
		col_1[c, page_number] = c_white
		col_2[c, page_number] = c_white
		col_3[c, page_number] = c_white
		col_4[c, page_number] = c_white
		
		float_text[c, page_number] = 0
		float_dir_x[c, page_number] = c * 20
		float_dir_y[c, page_number] = c * 20
		float_markiplier_x[c, page_number] = 1
		float_markiplier_y[c, page_number] = 1
		
		shake_text[c, page_number] = 0
		shake_dir[c, page_number] = irandom(360)
		shake_timer[c, page_number] = irandom(4)
		shake_modifier[c, page_number] = 2
		shake_break[c, page_number] = infinity
	}
	
	txtb_spr[page_number] = spr_textbox
	speaker_sprite[page_number] = noone
	speaker_side[page_number] = 1
	snd[page_number] = snd_speak_middle
}

//------------------Text VFX---------------------
/// @param speaking
/// @param 1st_char
/// @param last_char
/// @param topLeftCol
/// @param topRightCol
/// @param bottomRightCol
/// @param bottomLeftCol
function scr_text_color(_char_speaking, _start, _end, _col1, _col2, _col3, _col4) {
	switch(_char_speaking) {
		case "cade":
			_start += string_length(cadeSpeaks)
			_end += string_length(cadeSpeaks)
			break
		
		case "lucia":
			_start += string_length(luciaSpeaks)
			_end += string_length(luciaSpeaks)
			break
			
		case "rich":
			_start += string_length(richSpeaks)
			_end += string_length(richSpeaks)
			break
			
		case "mickey":
			_start += string_length(mickeySpeaks)
			_end += string_length(mickeySpeaks)
			break
		
	}
	
	for (var c = _start; c < _end; c++) {
	    col_1[c, page_number - 1] = _col1
	    col_2[c, page_number - 1] = _col2
	    col_3[c, page_number - 1] = _col3
	    col_4[c, page_number - 1] = _col4
	}
}

/// @param speaking
/// @param 1st_char
/// @param last_char
/// @param modifierX/distanceX
/// @param modifierY/distanceY
function scr_text_float(_char_speaking, _start, _end, _distance_x = 1, _distance_y = 1) {
	switch(_char_speaking) {
		case "cade":
			_start += string_length(cadeSpeaks)
			_end += string_length(cadeSpeaks)
			break
		
		case "lucia":
			_start += string_length(luciaSpeaks)
			_end += string_length(luciaSpeaks)
			break
			
		case "rich":
			_start += string_length(richSpeaks)
			_end += string_length(richSpeaks)
			break
			
		case "mickey":
			_start += string_length(mickeySpeaks)
			_end += string_length(mickeySpeaks)
			break
		
	}
	
	for (var c = _start; c < _end; c++) {
	    float_text[c, page_number - 1] = true
	    float_markiplier_x[c, page_number - 1] = _distance_x
	    float_markiplier_y[c, page_number - 1] = _distance_y
	}
}

/// @param speaking
/// @param 1st_char
/// @param last_char
/// @param modifier
/// @param timer/seconds
function scr_text_shake(_char_speaking, _start, _end, _modifier = 2, _timer = infinity) {
	switch(_char_speaking) {
		case "cade":
			_start += string_length(cadeSpeaks)
			_end += string_length(cadeSpeaks)
			break
		
		case "lucia":
			_start += string_length(luciaSpeaks)
			_end += string_length(luciaSpeaks)
			break
			
		case "rich":
			_start += string_length(richSpeaks)
			_end += string_length(richSpeaks)
			break
			
		case "mickey":
			_start += string_length(mickeySpeaks)
			_end += string_length(mickeySpeaks)
			break
		
	}
	
	for (var c = _start; c < _end; c++) {
	    shake_text[c, page_number - 1] = true
		shake_modifier[c, page_number - 1] = _modifier
		shake_break[c, page_number - 1] = _timer * 60
	}
}

/// @param string
/// @param [character]
function scr_text(_text){
	scr_set_defaults_for_text()
	
	text[page_number] = _text
	
	//get char info
	if argument_count > 1 {
		switch(argument[1]) {
			case "cade":
				speaker_sprite[page_number] = spr_player_spk
				speaker_side[page_number] = 1
				snd[page_number] = snd_speak_middle
				break
		
			case "lucia":
				speaker_sprite[page_number] = spr_player_spk
				speaker_side[page_number] = 1
				snd[page_number] = snd_speak_middle
				break
			
			case "rich":
				speaker_sprite[page_number] = spr_player_spk
				speaker_side[page_number] = 1
				snd[page_number] = snd_speak_middle
				break
			
			case "mickey":
				speaker_sprite[page_number] = spr_player_spk
				speaker_side[page_number] = 1
				snd[page_number] = snd_speak_middle
				break
		}
	}
	page_number++
}

/// @param text_id
function create_textbox(_text_id) {
	with (instance_create_depth(0, 0, -5000, obj_textbox)) {
		scr_game_text(_text_id)
	}
}

/// @param option
/// @param link_id
function scr_options(_option, _link_id) {
	option[option_number] = _option
	option_link_id[option_number] = _link_id
	
	option_number++
}
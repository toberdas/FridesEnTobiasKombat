extends Control

func set_text(text:String):
	$Label.text = text
	if text == "":
		$Label.visible = false
	else:
		$Label.visible = true

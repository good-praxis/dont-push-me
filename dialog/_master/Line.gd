extends Label

export(String, FILE) var nextLine
export(String, MULTILINE) var lineText

signal finished

var interrupted = false

func play():
	interrupted = false
	self.text = ""
	for letter in lineText:
		if interrupted:
			break
		if letter in " .,!?'\"" or !self.text:
			self.text += letter
			continue
		
		yield(get_tree().create_timer(0.05), "timeout")
		self.text += letter
	
	if not interrupted:
		emit_signal("finished", nextLine, lineText)
	
func interrupt():
	interrupted = true
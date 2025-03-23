extends AudioStreamPlayer

@onready var intro_music: AudioStreamWAV = load("res://Audio-Visual/Music/WAV/music-menu-intro.wav")
@onready var loop_music: AudioStreamWAV = load("res://Audio-Visual/Music/WAV/music-menu-loop.wav")

func _ready():
	stream = intro_music
	play()
	
	self.finished.connect(play_loop)
	
func play_loop():
	stream = loop_music
	play()

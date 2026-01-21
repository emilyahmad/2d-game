extends Node2D

@onready var background: TextureRect = $Background

@onready var game2: TextureButton = $Game1

var game2unlocked := false
var game3unlocked := false

#once unlocked, player clicks on icons (buttons)
#& taken to new scenes
const COLLECT_GAME_PATH = "res://Scenes/Collect-Game-Screen.tscn"
const AVOID_GAME_PATH = "res://Scenes/Avoid-Game-Screen.tscn"
const PLATFORM_GAME_PATH = "res://Scenes/Platform-Game-Screen.tscn"

#change intro background to show mini games
const INTRO_BACKGROUND := preload("res://HUD/Backgrounds/IntroBackground.png")
const LOBBY_BACKGROUND := preload("res://HUD/Backgrounds/LobbyBackground.png")
const END_BACKGROUND := preload("res://HUD/Backgrounds/EndBackground.png")

#change minigame preview to show if (un)locked
const game2islocked := preload("res://HUD/Minigames/2L.png")
const game2isunlocked := preload("res://HUD/Minigames/2.png")

const game3islocked := preload("res://HUD/Minigames/3L.png")
const game3isunlocked := preload("res://HUD/Minigames/3.png")

func _ready() -> void:
	background.texture = INTRO_BACKGROUND
	
	if game3unlocked:
		pass
	elif game2unlocked:
		pass
	else:
		pass

func _on_start_btn_pressed() -> void:
#changes to lobby background shows
#mini games that are unlocked
	background.texture = LOBBY_BACKGROUND

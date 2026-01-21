extends Node2D

signal hit

@onready var background: TextureRect = $Background

@onready var game2: TextureButton = $Game2Btn
@onready var game3: TextureButton = $Game3Btn

var game2unlocked := false
var game3unlocked := false

#once unlocked, player clicks on icons (buttons)
#& taken to new scenes
const COLLECT_GAME_PATH = "res://Scenes/collect_game.tscn"
const AVOID_GAME_PATH = "res://Scenes/avoid_game.tscn"
const PLATFORM_GAME_PATH = "res://Scenes/platform_game.tscn"

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
		game2.texture_normal = game2isunlocked
		game3.texture_normal = game3isunlocked
	elif game2unlocked:
		game2.texture_normal = game2isunlocked
		game3.texture_normal = game3islocked
	else:
		game2.texture_normal = game2islocked
		game3.texture_normal = game3islocked

func _on_start_btn_pressed() -> void:
#changes to lobby background shows
#mini games that are unlocked
	background.texture = LOBBY_BACKGROUND

func _on_game_1_btn_pressed() -> void:
	var new_scene_resource = load(COLLECT_GAME_PATH)
	get_tree().change_scene_to_packed(new_scene_resource)

func _on_game_2_btn_pressed() -> void:
	var new_scene_resource = load(AVOID_GAME_PATH)
	get_tree().change_scene_to_packed(new_scene_resource)

func _on_game_3_btn_pressed() -> void:
	var new_scene_resource = load(PLATFORM_GAME_PATH)
	get_tree().change_scene_to_packed(new_scene_resource)

extends Node2D

signal hit

@onready var background: TextureRect = $Background

@onready var game2: TextureButton = $Game2Btn
@onready var game3: TextureButton = $Game3Btn

#once unlocked, player clicks on icons (buttons)
#& taken to new scenes
const COLLECT_GAME_PATH = "res://Scenes/collect_game.tscn"
const AVOID_GAME_PATH = "res://Scenes/avoid_game.tscn"

#change intro background to show mini games
const INTRO_BACKGROUND := preload("res://HUD/Backgrounds/Lobby.png")
const LOBBY_BACKGROUND := preload("res://HUD/Backgrounds/LobbyBackground.png")
const END_BACKGROUND := preload("res://HUD/Backgrounds/EndBackground.png")

#change minigame preview to show if (un)locked

func _ready() -> void:
	background.texture = INTRO_BACKGROUND

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

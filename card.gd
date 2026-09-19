extends TextureButton

signal card_selected(card)

@export var back_texture: Texture2D

var card_id: int
var face_texture: Texture2D
var is_flipped := false
var is_matched := false


func _ready():
	pressed.connect(_on_pressed)
	texture_normal = back_texture


func setup(id: int, texture: Texture2D):
	card_id = id
	face_texture = texture


func _on_pressed():
	card_selected.emit(self)


func flip():
	is_flipped = true
	texture_normal = face_texture


func hide_card():
	is_flipped = false
	texture_normal = back_texture

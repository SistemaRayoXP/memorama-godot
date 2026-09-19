extends Control

const CARD_SCENE := preload("res://card.tscn")

@onready var card_container: GridContainer = $ContenedorDeCartas

@export var card_textures: Array[Texture2D] = []

@export var pair_count: int = 5

var selected_card = null
var can_select_cards: bool = true
var matched_pairs: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_cards()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func restart_game() -> void:
	can_select_cards = true
	selected_card = null
	matched_pairs = 0

	for child in card_container.get_children():
		child.queue_free()

	update_status()
	create_cards()


func create_deck() -> Array[int]:
	var available_ids := range(card_textures.size())
	available_ids.shuffle()

	var selected_ids := available_ids.slice(
		0,
		min(pair_count, available_ids.size())
	)

	var deck: Array[int] = []

	for card_id in selected_ids:
		deck.append(card_id)
		deck.append(card_id)

	deck.shuffle()

	return deck


func create_cards() -> void:
	var deck := create_deck()

	for card_id in deck:
		var card = CARD_SCENE.instantiate()

		card.setup(card_id, card_textures[card_id])
		card.card_selected.connect(_on_card_selected)

		card_container.add_child(card)


func _on_card_selected(card) -> void:
	if matched_pairs == pair_count:
		restart_game()

	if card.is_flipped or card.is_matched or not can_select_cards:
		return
	
	card.flip()

	if selected_card == null:
		selected_card = card
		return

	can_select_cards = false

	if selected_card.card_id == card.card_id:
		card.is_matched = true
		selected_card.is_matched = true
		selected_card = null
		can_select_cards = true
		matched_pairs += 1
		update_status()

	else:
		await get_tree().create_timer(1.0).timeout
		card.hide_card()
		selected_card.hide_card()
		selected_card = null
		can_select_cards = true


func update_status():
	if matched_pairs < pair_count:
		$HUD/StatusLabel.text = "Parejas " + str(matched_pairs) + "/" + str(pair_count)
	elif matched_pairs == pair_count:
		$HUD/StatusLabel.text = "¡Ganaste! Presiona cualquier carta para reiniciar."

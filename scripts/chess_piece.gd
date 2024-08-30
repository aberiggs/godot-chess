extends Node2D

const tile_size = 22
const board_origin = Vector2(-4 * tile_size, 4 * tile_size)
const offset = Vector2(tile_size * 0.5, -tile_size * 0.5)

var piece_type: String
var is_white: bool
var board_position: Vector2

func _ready():
    # Initialize the piece (e.g., set initial position)
    pass

func is_position_under_cursor(mouse_position: Vector2) -> bool:
    # Check if the mouse click is on the piece
    return get_rect().has_point(mouse_position)

func board_pos_to_position(board_position: Vector2):
    return board_position * Vector2(1, -1) * tile_size + board_origin + offset 

# Zero-indexed (col: 0-7, row: 0-7)
func move_to(new_position: Vector2):
    # Basic move functionality common to all pieces
    board_position = new_position

    position = board_pos_to_position(board_position)

func get_rect() -> Rect2:
    # Get the bounding rectangle of the pieces sprite
    return Rect2(position - Vector2(tile_size / 2, tile_size / 2), Vector2(tile_size, tile_size))

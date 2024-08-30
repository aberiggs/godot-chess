extends "res://scripts/chess_piece.gd"

func _ready():
    piece_type = "King"
    # Additional initialization specific to the queen
    pass

func get_valid_moves(board):
    # Override to implement King's specific movement logic
    var valid_moves = []
    # Calculate valid moves for a King
    return valid_moves

func move_piece():
    # Handle the movement logic
    var new_position = board_position + Vector2(0, 1)  # Example new position; update based on game logic
    
    move_to(new_position)
    

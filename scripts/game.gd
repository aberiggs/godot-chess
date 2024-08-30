extends Node2D

var piece_scenes = {
    #'P': preload("res://scenes/White_Pawn.tscn"),
    #'N': preload("res://scenes/White_Knight.tscn"),
    #'B': preload("res://scenes/White_Bishop.tscn"),
    #'R': preload("res://scenes/White_Rook.tscn"),
    #'Q': preload("res://scenes/White_Queen.tscn"),
    'K': preload("res://scenes/White_King.tscn"),
    #'p': preload("res://scenes/Black_Pawn.tscn"),
    #'n': preload("res://scenes/Black_Knight.tscn"),
    #'b': preload("res://scenes/Black_Bishop.tscn"),
    #'r': preload("res://scenes/Black_Rook.tscn"),
    #'q': preload("res://scenes/Black_Queen.tscn"),
    'k': preload("res://scenes/Black_King.tscn")
}

@onready var pieces_container = $PiecesContainer  # Adjust the path if needed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1" # Starting pos
    construct_board_from_fen(fen)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(event):
    if event is InputEventMouseButton and event.pressed:
        for piece in pieces_container.get_children():
            if piece.is_position_under_cursor(get_global_mouse_position()):
                var to = piece.board_position + Vector2(0, 1)
                piece.move_to(to)
       
func legal_moves():
    return []
         
func construct_board_from_fen(fen: String) -> void:
    # Clear the old board
    for piece in pieces_container.get_children():
        pieces_container.remove_child(piece)
    
    # Extract the board part from the FEN string
    var board_part = fen.split(" ")[0]
    
    # Iterate through each row of the board
    var rows = board_part.split("/")
    for row_index in range(8):
        var row = rows[row_index]
        var col_index = 0
        for char in row:
            if char.is_valid_int():
                # Empty squares
                col_index += int(char)
            else:
                # Place piece
                var piece_scene = piece_scenes.get(char, null)
                if piece_scene:
                    var piece = piece_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
                    piece.move_to(Vector2(col_index, 7 - row_index))
                    pieces_container.add_child(piece)
                col_index += 1
    
    
        

extends Node2D

var white_king_scene = preload("res://scenes/White_King.tscn")
var black_king_scene = preload("res://scenes/Black_King.tscn")

@onready var pieces_container = $PiecesContainer  # Adjust the path if needed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

    var white_bitboard = 0b0000000000000000000000000000000000000000000000000000000000000000 # Example white bitboard
    var black_bitboard = 0
    print(black_bitboard + 0b1111111111101111111111110000000000000000111111111111111111111111) # Example black bitboard

    # Add white pieces
    add_pieces_from_bitboard(white_bitboard, true)
    # Add black pieces
    add_pieces_from_bitboard(black_bitboard, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _input(event):
    if event is InputEventMouseButton and event.pressed:
        for piece in pieces_container.get_children():
            if piece.is_position_under_cursor(get_global_mouse_position()):
                var to = piece.board_position + Vector2(0, 1)
                piece.move_to(to)
                
func get_bitboard(is_white: bool):
    var bitboard: int = 0  # Initialize bitboard as a 64-bit integer (in Godot, `int` is 64-bit)
    
    for piece in pieces_container.get_children():
        if piece.is_white != is_white:
            continue # color doesn't match
        # Calculate the bitboard index from the piece's position
        var x = piece.board_position.x
        var y = piece.board_position.y
        
        # Ensure coordinates are within bounds
        if x >= 0 and x < 8 and y >= 0 and y < 8:
            var index = y * 8 + x
            bitboard |= (1 << index)  # Set the corresponding bit
        else:
            assert(false, "Bitboard has coord out of bounds")
            
    
    return bitboard

func add_pieces_from_bitboard(bitboard: int, is_white: bool):
    # Clear the old board
    for piece in pieces_container.get_children():
        if piece.is_white == is_white:
            pieces_container.remove_child(piece)
    
    for index in range(64):  # 64 squares on a chessboard
        if bitboard & (1 << index):  # Check if the bit at `index` is set
            var x = index % 8
            var y = index / 8
            
            # Instantiate the appropriate piece based on color
            var piece_scene = white_king_scene if is_white else black_king_scene
            var piece = piece_scene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
            
            # Set the piece's color
            piece.is_white = is_white
            
            # Set the position of the piece
            piece.move_to(Vector2(x,y))
            
            # Add the piece to the container
            pieces_container.add_child(piece)
        
    
    
        

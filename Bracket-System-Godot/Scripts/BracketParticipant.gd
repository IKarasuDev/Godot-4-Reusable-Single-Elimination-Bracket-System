extends RefCounted
class_name BracketParticipant

# ------------------------------------------------------------
# BracketParticipant
# ------------------------------------------------------------
# Represents a single competitor inside the tournament system.
# This class is intentionally generic and does not contain any
# gameplay logic. It can represent a car, player, AI agent,
# character, or any competitive entity.
#
# The "data" field allows attaching contextual information
# depending on the game implementation.
# ------------------------------------------------------------

var id: String                 # Unique identifier for the participant
var data: Variant              # Optional contextual data (car object, stats, etc.)

func _init(_id: String, _data : Variant = null):
	# Initializes the participant with an ID and optional data payload.
	id = _id
	data = _data

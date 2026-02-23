extends RefCounted
class_name BracketMatch

# ------------------------------------------------------------
# BracketMatch
# ------------------------------------------------------------
# Represents a single 1v1 confrontation between two participants.
# This class does NOT decide the winner. It only stores the result.
#
# The winner must be externally determined (e.g., race simulation,
# PvP combat, AI resolution) and then reported to the match.
# ------------------------------------------------------------

var id: int                                # Unique match identifier
var participant_a: BracketParticipant      # First competitor
var participant_b: BracketParticipant      # Second competitor
var winner: BracketParticipant = null      # Winner of the match
var finished: bool = false                 # Indicates if result was reported


func _init(_id: int, a: BracketParticipant, b: BracketParticipant):
	# Creates a match with two participants.
	id = _id
	participant_a = a
	participant_b = b


func set_winner(p: BracketParticipant):
	# Assigns the winner of the match.
	# Validates that the winner is one of the two participants.
	
	if p != participant_a and p != participant_b:
		push_error("Winner must be one of the participants")
		return
	
	winner = p
	finished = true

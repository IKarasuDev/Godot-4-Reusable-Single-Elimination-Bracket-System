extends RefCounted
class_name BracketManager

# ------------------------------------------------------------
# BracketManager
# ------------------------------------------------------------
# Core engine of the single-elimination tournament system.
# Responsible for:
# - Creating tournament rounds
# - Managing match progression
# - Advancing winners
# - Determining the champion
#
# It does NOT simulate gameplay. It only manages structure.
# ------------------------------------------------------------

var rounds: Array = []                         # 2D array storing all rounds and their matches
var current_round_index: int = 0               # Index of the active round
var match_id_counter: int = 0                  # Incremental match ID generator
var champion: BracketParticipant = null        # Final winner of the tournament


func start(participants: Array) -> void:
	# Initializes the tournament.
	# Requires number of participants to be a power of two.
	
	assert(is_power_of_two(participants.size()))

	rounds.clear()
	current_round_index = 0
	match_id_counter = 0
	champion = null

	var first_round: Array = create_round(participants)
	rounds.append(first_round)


func get_current_matches() -> Array:
	# Returns all matches of the current active round.
	# Returns empty array if tournament is finished.
	
	if is_finished():
		return []
	return rounds[current_round_index]


func report_result(match_id: int, winner: BracketParticipant) -> void:
	# Reports the winner of a specific match.
	# If all matches in the round are finished,
	# the system automatically advances to the next round.
	
	var current_round: Array = rounds[current_round_index]

	for m in current_round:
		if m.id == match_id:
			m.set_winner(winner)
			break

	if is_round_finished(current_round):
		advance_round()


func is_round_finished(round: Array) -> bool:
	# Checks whether every match in a round has finished.
	
	for m in round:
		if not m.finished:
			return false
	return true


func advance_round() -> void:
	# Collects winners from the finished round and
	# creates the next round. If only one winner remains,
	# that participant becomes the champion.
	
	var finished_round: Array = rounds[current_round_index]
	var winners: Array = []

	for m in finished_round:
		winners.append(m.winner)

	if winners.size() == 1:
		champion = winners[0]
		return

	current_round_index += 1
	var next_round: Array = create_round(winners)
	rounds.append(next_round)


func is_finished() -> bool:
	# Returns true if a champion has been determined.
	return champion != null


func get_champion() -> BracketParticipant:
	# Returns the final tournament winner.
	return champion


func create_round(participants: Array) -> Array:
	# Creates a round by pairing participants sequentially.
	# Each pair becomes a BracketMatch instance.
	
	var matches: Array = []

	for i in range(0, participants.size(), 2):
		match_id_counter += 1
		var new_match := BracketMatch.new(
			match_id_counter,
			participants[i],
			participants[i + 1]
		)
		matches.append(new_match)

	return matches


func is_power_of_two(n: int) -> bool:
	# Utility method.
	# Required for proper single-elimination structure.
	return n > 0 and (n & (n - 1)) == 0

extends Node

# ------------------------------------------------------------
# Tournament Test Script
# ------------------------------------------------------------
# Simulates a full tournament using random winners.
# Used only to validate structural correctness.
# No gameplay integration required.
# ------------------------------------------------------------

func _ready():
	randomize()
	run_test()


func run_test():
	# Create dummy participants
	var participants: Array = []

	for i in range(8):
		var p = BracketParticipant.new("Player_%d" % i)
		participants.append(p)

	# Initialize manager
	var manager = BracketManager.new()
	manager.start(participants)

	print("=== START TOURNAMENT ===")

	# Simulate tournament progression
	while not manager.is_finished():
		var matches = manager.get_current_matches()

		print("--- New Round ---")

		for m in matches:
			print("Match %d: %s vs %s" % [
				m.id,
				m.participant_a.id,
				m.participant_b.id
			])

			# Random winner simulation
			var winner = m.participant_a
			if randi() % 2 == 0:
				winner = m.participant_b

			print("Winner:", winner.id)

			manager.report_result(m.id, winner)

	print("=== TOURNAMENT FINISHED ===")
	print("Champion:", manager.get_champion().id)

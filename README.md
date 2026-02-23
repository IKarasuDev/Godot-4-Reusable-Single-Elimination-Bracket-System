# Godot 4 – Reusable Single-Elimination Bracket System

## Overview

This project provides a reusable and fully decoupled single-elimination tournament system for Godot 4.

The system is designed to manage competitive structures independently of gameplay logic. It can be integrated into racing games, PvP combat systems, card games, AI simulations, or any scenario that requires structured 1v1 elimination brackets.

The core goal of this project is to demonstrate clean architecture, separation of concerns, and scalable system design for game development.

## Features

 - Single-elimination bracket structure

- Fully decoupled from gameplay logic

- Works with any type of participant

- Deterministic round progression

- Automatic round advancement

- Champion resolution

- Easily extendable for advanced tournament systems

## Architecture Overview
the system is composet of three core scripts

- BracketParticipant = Represents a competitor
- BracketMatch = Represents 1v1 competition
- BracketManager = Controlls tournament structure and progression

## Layered Structure


```bash
BracketParticipant -> BracketMatch -> BracketManager
```
## Responsability separation
- BracketParticipant does not know about matches or tournaments.

- BracketMatch does not simulate results.

- BracketManager does not execute gameplay logic.

- The system never decides winners internally.

This enforces strict separation of concerns and allows the bracket to be reused across different gameplay contexts.

## How it works

### 1. Initialization
the tournament is initializing using

```bash
manager.start(participants)
```
The number of participants must be a power of two (2, 4, 8, 16, 32, etc.).

The first round is generated automatically by pairing participants sequentially

### 2. Match execution (External system)
The bracket system does not simulate gameplay.

Instead, your game logic (e.g., RaceManager, CombatSystem) runs the match and determines a winner.

Example:

```python
var car_a = match.participant_a.data
var car_b = match.participant_b.data
```
your gameplays system decides the winner

### 3. Reporting results
once the winner is known

```python
manager.report_result(match.id, winner_participant)
```
If all matches in the round are finished, the system automatically advances to the next round.

### 4. Champion result
When only one participant remains: 

```python
manager.get_champion()
```
The tournament is considered complete

## Example integration - 1v1 Car Racing
The system can be integrated into a racing game as follows:

### Step 1 - Wrap Cars As participants
```python
var car = Car.new()
var participant = BracketParticipant.new("Car_01", car)
```
- id -> display name
- data -> actual Car instance

### Step 2 - Start Tournament
```python
manager.start(car_participants)
```

### Step 3 - Run Race for Each Match
```python
var car_a = match.participant_a.data
var car_b = match.participant_b.data
```
Pass both cars into your race system

### Step 4 - Report Winnner
```python
manager.report_result(match.id, winner_participant)
```
The bracket progresses automatically

## API Reference
#### start(participants: Array)

Initializes the tournament and creates the first round.

#### get_current_matches() -> Array

Returns the list of matches in the active round.

#### report_result(match_id: int, winner: BracketParticipant)

Registers a winner and advances the round if all matches are finished.

#### is_finished() -> bool

Returns true when a champion has been determined.

#### get_champion() -> BracketParticipant

Returns the final tournament winner.

#### create_round(participants: Array) -> Array

Pairs participants sequentially into matches.

#### is_power_of_two(n: int) -> bool

Validates the required structure for single-elimination brackets.


## Scaling the Bracket
The system supports any number of participants that is a power of two:

- 2
- 4
- 8
- 16
- 32
- 64
- etc.

To expand the bracket, simply pass more participants.

For non-power-of-two cases, possible approaches include:

- Adding "bye" participants
- Implementing auto-balancing logic before initialization
- Seeding participants before pairing

## Possible Extensions
This system can be extended with:

- Double-elimination support
- Seeding logic
- Persistent tournament save/load
- Visual bracket UI generation
- Networked multiplayer integration

## Design Goals
- Reusability
- Decoupled gameplay logic
- Clear responsibility boundaries
- Scalability
- Clean and readable implementation

## License

[MIT](https://choosealicense.com/licenses/mit/)

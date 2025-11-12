extends Resource
class_name StatModifier

enum Stat {DAMAGE, MAX_HP, MOVE_SPEED, REGEN, ATTACK_SPEED, CRIT_CHANCE, LUCK}

@export var stat: Stat
@export var flat_bonus: float = 0.0
@export var percent_bonus: float = 0.0

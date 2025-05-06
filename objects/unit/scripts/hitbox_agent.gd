class_name HitBoxAgent extends Area2D

signal got_damage(value: float, source: DamageAgent)


func _ready():
	self.got_damage.connect(hit)

func hit(value: float, source: DamageAgent):
	pass
	

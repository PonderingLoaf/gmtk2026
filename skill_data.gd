class_name SkillData
extends Resource

@export var skill_name: String = ""
@export var description: String = ""
@export var cannot_buy_texture: Texture2D
@export var can_buy_texture: Texture2D
@export var unlocked_texture: Texture2D
@export var requirements: Array[SkillData] = []
@export var stat_changes: Dictionary = {}
@export var is_unlocked: bool = false
@export var blood_price: int = 0

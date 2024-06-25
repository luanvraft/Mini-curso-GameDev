extends RigidBody2D

#pega o nó das animações pra manipulação em código
@onready var anim = $anim
#função que sempre executa quando a cena é aberta pela primeira vez
func _ready():
	#variavel que armazena os nomes das animações
	var enemy_types = anim.sprite_frames.get_animation_names()
	#código que faz os inimigos aparecerem aleatoriamente no mapa
	anim.play(enemy_types[randi() % enemy_types.size()])

#função que é executada quando o dono desse script sai da tela
func _on_visible_screen_exited():
	#método que deleta o nó da cena
	queue_free()

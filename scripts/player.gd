extends Area2D

#sinal enviado pelo player quando ele for acertado
signal hit

#define a velocidade do player
const SPEED := 400

#pega o tamanho máximo da tela
@onready var screen_size = get_viewport_rect().size

#pega o nó das animações pra manipulação em código
@onready var anim = $anim

#pega o nó do colisor pra manipulação em código
@onready var collision = $collision

#função que sempre executa quando a cena é aberta pela primeira vez
func _ready():
	#método que esconde o player
	hide()
	
#função chamada a cada frame. 'delta' é o tempo decorrido desde o frame anterior.
func _process(delta):
	#define a direção do movimento do player
	var velocity = Input.get_vector("move_left","move_right","move_up","move_down")
	
	#define a movimentação do player
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	#define a animação que vai rodar com base na movimentação do player
	if velocity.x != 0:
		anim.play("move")
	elif velocity.y < 0:
		anim.play("move_up")
	elif velocity.y > 0:
		anim.play("move_down")
	else:
		anim.play("idle")
	
	#espelha o player quando ele for pra direita ou esquerda
	if velocity.x > 0:
		anim.flip_h = false
	else:
		anim.flip_h = true
	
	#faz o player se movimentar
	position += velocity * delta
	
	#define a borda do mapa impedindo que o player saia da tela
	position = position.clamp(Vector2.ZERO, screen_size)

#função que identifica se houve colisão entre corpos
func _on_body_entered(body):
	#método que esconde o player 
	hide()
	#método que avisa que o player foi acertado
	hit.emit()
	#método que desabilita a colisão do player com um certo atraso
	collision.set_deferred("disabled", true)

#função que define a posição inicial do player
func start_pos(pos):
	position = pos
	#método que deixa o player visivel
	show()
	#método que habilita a colisão do player
	collision.disabled = false

extends Node2D

#deixa a variável editavel no inspetor, o tipo da variavel é de cena
@export var bug_scene : PackedScene
#variavel que conta a pontuação
var score

#função que executa ao perder
func game_over():
	#para o aparecimento de inimigos
	$BugTimer.stop()
	#para a contagem de pontos
	$ScoreTimer.stop()
	#chama a tela de game over
	$hud.show_game_over()
	#para a música de fundo
	$bgMusic.stop()
	#toca a música de game over
	$GameOverSound.play()

#função para iniciar um novo jogo
func new_game():
	#inicia o timer
	$StartTimer.start()
	#coloca o player na possição de inicio
	$player.start_pos($StartPosition.position)
	#zera a pontuação
	score = 0
	#manda a pontuação pra atualizar o numero
	$hud.update_score(score)
	#mostra uma mensagem na tela
	$hud.show_message("Prepare-se!")
	#remove todos os membros do grupo bugs da cena
	get_tree().call_group("bugs", "queue_free")
	#toca a música de fundo
	$bgMusic.play()

#função para aumentar o contador de pontos
func _on_score_timer_timeout():
	#aumenta a pontção sempre q o timer zerar
	score += 1
	#manda a pontuação pra atualizar o numero
	$hud.update_score(score)

#função para iniciar o aparecimento de inimigos e a contagem da pontuação
func _on_start_timer_timeout():
	$BugTimer.start()
	$ScoreTimer.start()

#função que controla o aparecimento de inimigos
func _on_bug_timer_timeout():
	#transforma a cena do inimigo numa variavel para ser manipulavel
	var bug = bug_scene.instantiate()
	#transforma a área de apareceimento de inimigos numa variavel para ser manipulavel
	var bug_location = $BugPath/BugPathLocation
	#deixa a localização do aparecimento de inimigos aleatoria no caminho definido
	bug_location.progress_ratio = randf()
	#direção que os inimigos vão seguir
	var direction = bug_location.rotation + PI / 2
	#definição da posição que os inimigos vão ser invocados
	bug.position = bug_location.position
	#randomiza a direção que os inimigos vão seguir
	direction += randf_range(-PI / 4, PI / 4)
	bug.rotation = direction
	#variavel que controla a velocidade dos inimigos
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	#definie a direção que o inimigo vai seguir
	bug.linear_velocity = velocity.rotated(direction)
	#método que adiciona o inimigo  
	add_child(bug)

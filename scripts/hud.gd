extends CanvasLayer

#sinal que ativa quando o jogo for iniciado
signal start_game
#pega o nó da pontuação pra manipulação em código
@onready var score_label = $Control/ScoreLabel
#pega o nó da mensagem que aparece na tela pra manipulação em código
@onready var message_label = $Control/MessageLabel
#pega o nó do timer da mensagem pra manipulação em código
@onready var message_timer = $MessageTimer
#pega o nó do botão de start pra manipulação em código
@onready var start_button = $Control/StartButton

#função que atualiza a mensagem mostrada na tela
func show_message(text):
	#atualiza o texto da label
	message_label.text = text
	#mostra a mensagem na tela
	message_label.show()
	#inicia o timer da mensagem
	message_timer.start()

#função que mostra a tela de game over
func show_game_over():
	#reescreve a mensagem da label
	show_message("Game Over")
	#espera o timer da mensagem acabar
	await message_timer.timeout
	#reescreve a mensagem da label pro texto original
	message_label.text = "desvie dos insetos"
	#mostra a mensagem na tela
	message_label.show()
	#espera que um timer temporario seja criado e encerrado
	await get_tree().create_timer(1.0).timeout
	#mostra o botão de start
	start_button.show()

#função que atualiza a pontuação
func update_score(score):
	#atualiza a pontuação convertendo o numero(int) pra texto(str)
	score_label.text = str(score)

#função que executa quando o botão de start é pressionado
func _on_start_button_pressed():
	#esconde o botão de start
	start_button.hide()
	#emite um sinal indicando que o jogo começou
	start_game.emit()
#função que executa quando o timer da mensagem zerar
func _on_message_timer_timeout():
	#esconde a mensagem que aparece na tela
	message_label.hide()

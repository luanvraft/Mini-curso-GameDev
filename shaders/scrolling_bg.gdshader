shader_type canvas_item;
//deifine uma varievel decimal, pra velocidade, editavel no inspetor0
uniform float speed = 1.0;

void fragment() {
//cria o efeito de animação
 COLOR = texture(TEXTURE, vec2(UV.x, UV.y + TIME * speed));
}
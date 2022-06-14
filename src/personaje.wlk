import wollok.game.*

class Personaje {
	
	var property image = null
	var property position
	var property estoyAgregado = false
	
	method imagen(unaImagen) {image = unaImagen}
	method posicion(unaPosicion) {position = unaPosicion}
	method habilitar(){estoyAgregado = true}
	method deshabilitar() {estoyAgregado = false}
	method moverse()
	method colisionaConEnemigo(unSonido){}
	method emitirMensaje(mensaje){
			if(self.estoyAgregado()) game.say(self, mensaje)
		}
}

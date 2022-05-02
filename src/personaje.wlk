import wollok.game.*

class Personaje {
	
		var property estoyAgregado = false
		
		method agregar(){estoyAgregado = true}
		method quitar() {estoyAgregado = false}
		method desplazarse(){}
		method colisionaConEnemigo(){}
		method emitirMensaje(mensaje){
			if(self.estoyAgregado()) game.say(self, mensaje)
		}
		
}

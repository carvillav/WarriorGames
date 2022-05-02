import wollok.game.*
import personaje.*
import cartel.*

class Guerrero inherits Personaje{
	var property position = null
	var property poder = 0
	
	method image() {
		if(poder >= 7000 && poder < 13000){
			return "guerreroNegro.png"
		}
		if(poder >= 13000){
			return "guerreroFinal.png"
		}
		return "guerreroPrincipal.png"
	}
	
	override method desplazarse(){
		keyboard.left().onPressDo({self.moverALaIzquierda()})
		keyboard.right().onPressDo({self.moverALaDerecha()})
		keyboard.up().onPressDo({self.moverArriba()})
		keyboard.down().onPressDo({self.moverAbajo()})
	}
	
	override method colisionaConEnemigo(){
		game.onCollideDo(self,{algo => algo.colisiona(self)
			
			if(self.poder() < 13000){
				algo.emitirMensaje("¡Humano, eres debil!")
			}else{
				algo.emitirMensaje("¡Al fin, un digno oponente!")
			}
		})
	}
	
	method moverALaDerecha(){
		position = position.right(1)
	}
	method moverALaIzquierda(){
		position = position.left(1)
	}
	method moverArriba(){
		position = position.up(1)
	}
	method moverAbajo(){
		position = position.down(1)
	}
	
	method aumentaPoder(cantColisiones){
		poder += 500*cantColisiones
	}
	
}

	//Guerrero
	const warrior = new Guerrero(position = game.at(3,5), poder = 1000, estoyAgregado = false)
	const textoPoderGuerrero = new Cartel(personaje = warrior, position = game.origin())

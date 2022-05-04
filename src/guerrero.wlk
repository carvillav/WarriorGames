import wollok.game.*
import personaje.*
import cartel.*
import pantalla.*

class Guerrero inherits Personaje{
	var property position = null
	var property poder = 0
	const property dimensionDePantallaEnJuego
	
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
	
	override method colisionaConEnemigo(escenario){
		game.onCollideDo(self,{algo => algo.colisiona(self, escenario)})
	}
	
	method moverALaDerecha(){
		if(position.x() < dimensionDePantallaEnJuego.anchoPantalla()-2) position = position.right(1)
	}
	method moverALaIzquierda(){
		if(position.x() > 0) position = position.left(1)
	}
	method moverArriba(){
		if(position.y() < dimensionDePantallaEnJuego.altoPantalla()-4) position = position.up(1)
	}
	method moverAbajo(){
		if(position.y() > 0) position = position.down(1)
	}
	
	method aumentaPoder(cantColisiones){
		poder += 500*cantColisiones
	}
	
}

	//Guerrero
	const warrior = new Guerrero(position = game.at(3,5), poder = 1000, estoyAgregado = false, dimensionDePantallaEnJuego = dimensionDeMiPantalla)
	const textoPoderGuerrero = new Cartel(personaje = warrior, position = game.origin())

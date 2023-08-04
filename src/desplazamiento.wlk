import wollok.game.*

class Desplazamiento {
	
	const property dimensionDePantalla
	
	method desplazarse(personaje){
		game.onTick(2000, self.identity().toString(), {self.moverse(personaje)})
	}
	
	method moverse(personaje){}
	
}

class DesplazarIzquierda inherits Desplazamiento{
	
	override method desplazarse(personaje){
		keyboard.left().onPressDo({self.moverALaIzquierda(personaje)})
	}
	
	method moverALaIzquierda(personaje){
		if(personaje.position().x() > 0) personaje.posicion(personaje.position().left(1))
	}
}

class DesplazarDerecha inherits Desplazamiento{
	
	override method desplazarse(personaje){
		keyboard.right().onPressDo({self.moverALaDerecha(personaje)})		
	}
	
	method moverALaDerecha(personaje){
		if(personaje.position().x() < dimensionDePantalla.ancho()-2) personaje.posicion(personaje.position().right(1))
	}
}

class DesplazarArriba inherits Desplazamiento{
	
	override method desplazarse(personaje){
		keyboard.up().onPressDo({self.moverArriba(personaje)})
	}
	
	method moverArriba(personaje) {
		if(personaje.position().y() < dimensionDePantalla.alto()-4) personaje.posicion(personaje.position().up(1)) 
	}
}

class DesplazarAbajo inherits Desplazamiento{
	
	override method desplazarse(personaje){
		keyboard.down().onPressDo({self.moverAbajo(personaje)})
	}
	method moverAbajo(personaje) {
		if(personaje.position().y() > 0) personaje.posicion(personaje.position().down(1))
	}
}

class DesplazarAutomaticamenteVertical inherits Desplazamiento{
	
	const property posicionFija
	
	override method moverse(personaje){
		
		2.times({x => personaje.posicion(personaje.position().down(1))})	
		if(personaje.position().y() < 0) personaje.posicion(self.posicionFija())
	}
}

class DesplazarAutomaticamenteHorizontal inherits Desplazamiento{
	
	var moverseALaIzquierda = true
	
	override method desplazarse(personaje){
		game.onTick(500, self.identity().toString(), {self.moverse(personaje)})
	}
	
	override method moverse(personaje){
		
		if(moverseALaIzquierda){
			self.moverseIzquierda(personaje)
		}else{
			self.moverseDerecha(personaje)
		}		
	}
	
	method moverseIzquierda(personaje){
		
		personaje.imagen("basilisco1.png")
		2.times({a => personaje.posicion(personaje.position().left(1))})
		if(personaje.position().x() <= 0) moverseALaIzquierda = false
	}
	
	method moverseDerecha(personaje){
		
		personaje.imagen("basilisco2.png")
		2.times({b => personaje.posicion(personaje.position().right(1))})
		if(personaje.position().x() == game.center().x()) moverseALaIzquierda = true
	}
}

class GirarEnSuPropioLugar inherits Desplazamiento{
	
	var nro = 0
	
	override method desplazarse(personaje){
		
		game.onTick(5000, self.identity().toString(), {
			nro = (nro + 1) % 2
			personaje.imagen("dragonNegro"+ nro.toString() + ".png")  
		})
	}
}

class DesplazamientoAleatorio inherits Desplazamiento{
	
	override method moverse(personaje){
		
		const x = (-5..30).anyOne()
    	const y = (-5..15).anyOne()
    	personaje.posicion(self.dentroDeLaPantalla(game.at(x,y)))
	}
	
	method dentroDeLaPantalla(posicion){
		
		var nuevaPosicion = posicion
		//nuevaPosicion.x(posicion.x().min(ancho-1).max(0))
		//nuevaPosicion.y(posicion.y().min(alto-1).max(0))
		if(posicion.x() >= dimensionDePantalla.ancho()) nuevaPosicion = game.at(dimensionDePantalla.ancho()-1, nuevaPosicion.y())
		if(posicion.x() < 0) nuevaPosicion = game.at(0, nuevaPosicion.y())
		if(posicion.y() >= dimensionDePantalla.alto()) nuevaPosicion = game.at(nuevaPosicion.x(), dimensionDePantalla.alto()-1)
		if(posicion.y() < 0) nuevaPosicion = game.at(nuevaPosicion.x(), 0)
		return nuevaPosicion
	}
}

import wollok.game.*
import warrior.*
import pantalla.*

class Enemy{
	
	var property image = null
	var property position = null
	var cantidadDesaparecidas = 0
	
	method coliciona(alguien){
		game.removeVisual(self)
		cantidadDesaparecidas++
		alguien.aumentaPoder(cantidadDesaparecidas)
		if(cantidadDesaparecidas < 3) game.addVisual(self)
		
	}
	
}

class MoverseEnVertical inherits Enemy {
	
	const property posicionFija
	
	method moverse(){
		2.times({x => position = position.down(1)})	
		if(position.y() < 0) position = posicionFija
	}
}

class MoverseAleatoriamente inherits Enemy {
	
	method moverse(){
		const x = (-5..30).anyOne()
    	const y = (-5..15).anyOne()
    	position = pantalla.dentroDeLaPantalla(game.at(x,y))
    }
}

class MoverseEnHorizontal inherits Enemy {
	
	var moverseALaIzquierda = true
	
	method moverse(){
		if(moverseALaIzquierda){
			self.moverseIzquierda()
		}else{
			self.moverseDerecha()
		}		
	}
	
	method moverseIzquierda(){
		
		2.times({a => position = position.left(1)})
		if(position.x() <= 0) moverseALaIzquierda = false
	}
	
	method moverseDerecha(){
		
		2.times({b => position = position.right(1)})
		if(position.x() == game.center().x()) moverseALaIzquierda = true
	}
}

class GirarEnSuLugar inherits Enemy {
	
	var nro = 0
	var property power
	
	method moverse(){
		game.onTick(5000, "dragonSeMueve", {
			nro = (nro + 1) % 2
			image = "dragonNegro"+ nro.toString() + ".png"
		})
	}
	
	override method coliciona(alguien){
		if(power < alguien.poder()){
			game.removeVisual(self)
			game.addVisual(victory)
		}else{
			pantalla.eliminarPersonajesDelJuego()
			game.addVisual(lose)
		}
	}
}


object victory {
	method position() = game.at(11,5)
	method image() = "you-win.png"
}

object lose {
	method position() = game.at(9,3)
	method image() = "game_over.png"
}
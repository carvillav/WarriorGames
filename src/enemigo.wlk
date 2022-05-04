import wollok.game.*
import guerrero.*
import pantalla.*
import personaje.*
import escenario.*
import fondo.*

class Enemigo inherits Personaje {
	
	var property image = null
	var property position = null
	var cantidadDesaparecidas = 0
	
	method colisiona(alguien, escenario){
		
		alguien.emitirMensaje("¡Uno Menos!") 
		game.removeVisual(self)
		cantidadDesaparecidas++
		alguien.aumentaPoder(cantidadDesaparecidas)
		if(cantidadDesaparecidas < 3) game.addVisual(self)
		
	}
	
	override method desplazarse(){
		game.onTick(2000, self.identity().toString(), {self.moverse()})
	}
	
	method moverse(){}
	
}

class QuedarseQuieto inherits Enemigo {
	
	override method emitirMensaje(mensaje){}
	
}

class MoverseEnVertical inherits Enemigo {
	
	const property posicionFija
	
	override method moverse(){
		2.times({x => position = position.down(1)})	
		if(position.y() < 0) position = posicionFija
	}
	
	override method emitirMensaje(mensaje){}
}

class MoverseAleatoriamente inherits Enemigo {
	
	const unaPantalla
	
	override method moverse(){
		const x = (-5..30).anyOne()
    	const y = (-5..15).anyOne()
    	position = unaPantalla.dentroDeLaPantalla(game.at(x,y))
    }
    
    override method emitirMensaje(mensaje){}
}

class MoverseEnHorizontal inherits Enemigo {
	
	var moverseALaIzquierda = true
	
	override method desplazarse(){
		game.onTick(500, self.identity().toString(), {self.moverse()})
	}
	
	override method moverse(){
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
	
	override method emitirMensaje(mensaje){}
}

class GirarEnSuLugar inherits Enemigo {
	
	var nro = 0
	var property power
	const victory
	const lose
	const sonidoVictory
	const sonidoLose
	
	override method desplazarse(){
		game.onTick(5000, "dragonSeMueve", {
			nro = (nro + 1) % 2
			image = "dragonNegro"+ nro.toString() + ".png"
		})
	}
	
	override method colisiona(alguien, escenario){
		if(power <= alguien.poder()){
			escenario.mostrarPantallaResultadoDeLaPartida(victory, sonidoVictory)
		}else{
			escenario.mostrarPantallaResultadoDeLaPartida(lose, sonidoLose)
		}
	}
}

	//Enemigos
	const boss = new GirarEnSuLugar(image = "dragonNegro0.png", 
		position = game.at(25,11), 
		power = 13000, 
		victory = victoria, 
		lose = derrota, 
		sonidoVictory = sonidoVictoria, 
		sonidoLose = sonidoDerrota
	)
	
	const enanoHechicero = new MoverseEnVertical(image = "enanoHechicero.png", position = game.at(1,15), posicionFija = game.at(1,15))
	const ladronZombie = new MoverseAleatoriamente(image = "ladronZombie.png", position = game.at(28,3), unaPantalla = pantallaJuego)
	const basilisco = new MoverseEnHorizontal(image = "basilisco.png", position = game.at(19,9))
	const esqueleto = new QuedarseQuieto(image= "esqueleto.png",  position = game.at(13,4))
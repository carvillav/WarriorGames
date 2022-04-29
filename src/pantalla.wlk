import wollok.game.*
import warrior.*
import enemy.*
import cartel.*

object pantalla {
	
	const alto = 18
	const ancho = 35
	
	const boss = new GirarEnSuLugar(image = "dragonNegro0.png", position = game.at(25,11), power = 10000)
	const enanoHechicero = new MoverseEnVertical(image = "enanoHechicero.png", position = game.at(1,15), posicionFija = game.at(1,15))
	const ladronZombie = new MoverseAleatoriamente(image = "ladronZombie.png", position = game.at(28,3))
	const basilisco = new MoverseEnHorizontal(image = "basilisco.png", position = game.at(19,9))
	const esqueleto = new Enemy(image= "esqueleto.png",  position = game.at(13,4))
	
	const warrior = new Warrior(position = game.at(3,5), poder = 1000, estoyAgregado = false)
	
	const textoPoderGuerrero = new Cartel(personaje = warrior, position = game.origin())
	
	method iniciar(){
		
		self.tamanioVentanaJuego(alto, ancho)
		self.agregarPesonajesJuego()
		self.desplazamiento()
		
		game.onCollideDo(warrior,{algo => 
			algo.coliciona(warrior)
			
			if(warrior.estoyAgregado())game.say(warrior, "¡Uno Menos!") 
			
			if(warrior.poder() <= 10000){
				if(warrior.estoyAgregado()) game.say(boss, "¡Humano, eres debil!")
			}else{
				game.say(boss, "¡Al fin, un digno oponente!")
			}
		})
		
		boss.moverse()
		game.start()
	}
	
	method tamanioVentanaJuego(altura, anchura){
		game.height(altura) //altura
		game.width(anchura) //ancho
		game.title("Warriors")
		game.boardGround("suelo.gif")
	}
	
	method dentroDeLaPantalla(posicion){
		var nuevaPosicion = posicion
		//nuevaPosicion.x(posicion.x().min(ancho-1).max(0))
		//nuevaPosicion.y(posicion.y().min(alto-1).max(0))
		if(posicion.x() >= ancho) nuevaPosicion = game.at(ancho-1, nuevaPosicion.y())
		if(posicion.x() < 0) nuevaPosicion = game.at(0, nuevaPosicion.y())
		if(posicion.y() >= alto) nuevaPosicion = game.at(nuevaPosicion.x(), alto-1)
		if(posicion.y() < 0) nuevaPosicion = game.at(nuevaPosicion.x(), 0)
		return nuevaPosicion
	}
	
	method desplazamiento(){
		keyboard.left().onPressDo({warrior.moverALaIzquierda()})
		keyboard.right().onPressDo({warrior.moverALaDerecha()})
		keyboard.up().onPressDo({warrior.moverArriba()})
		keyboard.down().onPressDo({warrior.moverAbajo()})
		
		game.onTick(2000, "movimientoLadronZombie", {ladronZombie.moverse()})
		game.onTick(2000, "movimientoEnanoHechicero", {enanoHechicero.moverse()})
		game.onTick(500, "movimientoBasilisco", {basilisco.moverse()})
		
		
	}
	
	method agregarPesonajesJuego(){
		game.addVisual(warrior)
		warrior.agregar()
		game.addVisual(textoPoderGuerrero)
		game.addVisual(boss)
		game.addVisual(enanoHechicero)
		game.addVisual(ladronZombie)
		game.addVisual(basilisco)
		game.addVisual(esqueleto)
	}
	
	method eliminarPersonajesDelJuego(){
		game.removeVisual(warrior)
		warrior.quitar()
		game.removeVisual(textoPoderGuerrero)
		game.removeVisual(boss)
		game.removeVisual(enanoHechicero)
		game.removeVisual(ladronZombie)
		game.removeVisual(basilisco)
		game.removeVisual(esqueleto)
	}
	
}

import wollok.game.*
import guerrero.*
import enemigo.*
import cartel.*
import tableroTiempo.*

object pantalla {
	
	const alto = 18
	const ancho = 35
	const tiempoReloj = 180000
	
	const boss = new GirarEnSuLugar(image = "dragonNegro0.png", position = game.at(25,11), power = 13000)
	const enanoHechicero = new MoverseEnVertical(image = "enanoHechicero.png", position = game.at(1,15), posicionFija = game.at(1,15))
	const ladronZombie = new MoverseAleatoriamente(image = "ladronZombie.png", position = game.at(28,3))
	const basilisco = new MoverseEnHorizontal(image = "basilisco.png", position = game.at(19,9))
	const esqueleto = new Enemigo(image= "esqueleto.png",  position = game.at(13,4))
	
	const warrior = new Guerrero(position = game.at(3,5), poder = 1000, estoyAgregado = false)
	
	const textoPoderGuerrero = new Cartel(personaje = warrior, position = game.origin())		
	
	method iniciar(){
		
		self.tamanioVentanaJuego(alto, ancho)
		self.agregarPesonajesJuego()
		self.desplazamiento()
		
		game.onCollideDo(warrior,{algo => algo.colisiona(warrior)
			
			if(warrior.poder() < 13000){
				self.emitirMensaje(warrior, boss, "¡Humano, eres debil!")
			}else{
				self.emitirMensaje(warrior, boss, "¡Al fin, un digno oponente!")
			}
		})
		
		if(warrior.estoyAgregado()) boss.moverse()
		
		const tiempo = new Tiempo(tiempoTotal = tiempoReloj, frecuencia = 1)
		const posicionReloj = game.at((ancho/2) - 1, (alto/2) - 1)
		generarNumerosVisibles.generarDigitos(tiempoReloj / 1000, tiempo, posicionReloj)
		tiempo.empezar()
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
	
	method emitirMensaje(encadenador, emite, mensaje){ 
		if(encadenador.estoyAgregado()) game.say(emite, mensaje)
	}
	
}

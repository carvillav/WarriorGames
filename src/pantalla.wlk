import wollok.game.*
import escenario.*
import fondo.*
import guerrero.*
import enemigo.*

class Pantalla {
	const property alto
	const property ancho
	const property image
	const property position
	const property titulo
	const property pantallaPortada
	const property pantallaOpciones
	const property pantallaJuego
	const property pantallaDerrota 
	const property sonidoIntro
	const property sonidoDerrotaFinal
	const property sonidoEscenarioJuego
	const property listaPersonajes
	
	method mostrarPantallaInicial(){
		
		self.configurarPantalla()
		self. mostrar(pantallaPortada)
		
		//reproduce automáticamente el sonido
    	sonidoIntro.reproducirAutomaticamente()
		
		//entra en un loop el sonido después de haber terminado
		sonidoIntro.reproducirSinParar()
		
		//Cerrar el juego
		self.cerrarPantalla()
		
		keyboard.enter().onPressDo{self.mostrarOpciones()}
	}
	
	method configurarPantalla(){
		game.height(alto)
		game.width(ancho)
		game.title(titulo)
		game.boardGround(image)
	}
	
	method mostrar(algo) {game.addVisual(algo)}
	
	method cerrarPantalla() {keyboard.s().onPressDo{game.stop()}}
	
	method mostrarOpciones(){
		
		game.clear()
		self.mostrar(pantallaOpciones)
		self.cerrarPantalla()
		keyboard.num1().onPressDo{self.iniciarJuego(110000)}
		keyboard.num2().onPressDo{self.iniciarJuego(70000)}
		keyboard.num3().onPressDo{self.iniciarJuego(50000)}
	}
	
	method iniciarJuego(tiempo){
		
		game.clear()
		
		const escenario = new Escenario(personajes = listaPersonajes, 
			image = pantallaJuego, 
			tiempoReloj = tiempo, 
			pantallaDerrota = pantallaDerrota,
			sonidoAmbiente = sonidoEscenarioJuego,
			musicaDerrota = sonidoDerrotaFinal
		)
	
	 	sonidoIntro.detener()
		
		escenario.iniciar()
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
}


//SONIDO
object sonido {

    method sonido(audio) = game.sound(audio + ".mp3")

    method reproducir(audio) = self.sonido(audio).play()
    
    method parar(audio) = self.sonido(audio).stop()

}

class DimensionPantalla{
	
	const property anchoPantalla
	const property altoPantalla
}

class Sonido {
	
	const property unSonido
	
	method reproducir() {unSonido.play()}
	method reproducirAutomaticamente() {game.schedule(1, {=> self.reproducir()})}
	method reproducirSinParar() = unSonido.shouldLoop(true)
	method detener() {unSonido.stop()}
	method bajarVolumen(cant) {unSonido.volume(cant)}
}

	//Sonidos
	
	const sonidoInicial = new Sonido(unSonido = sonido.sonido("musica/intro"))
	const sonidoJuego = new Sonido(unSonido = sonido.sonido("musica/ambiente"))
	const sonidoVictoria = new Sonido(unSonido = sonido.sonido("musica/victoria"))
	const sonidoDerrota = new Sonido(unSonido = sonido.sonido("musica/derrota"))
	
	//Pantalla
	
	const dimensionDeMiPantalla = new DimensionPantalla(anchoPantalla = 35, altoPantalla = 18)
	
	const pantallaJuego = new Pantalla(alto = dimensionDeMiPantalla.altoPantalla(), 
		ancho = dimensionDeMiPantalla.anchoPantalla(), 
		position = game.center(), 
		titulo = "Warriors", 
		image = "fondoNegro.jpg", 
		listaPersonajes = [warrior, boss, enanoHechicero, ladronZombie, basilisco, esqueleto],
		pantallaPortada = pantallaInicial, 
		pantallaOpciones = pantallaModoDeJuego,
		pantallaJuego = imagenEscenario,
		pantallaDerrota = derrota,
		sonidoIntro = sonidoInicial, 
		sonidoDerrotaFinal = sonidoDerrota,
		sonidoEscenarioJuego = sonidoJuego
	)
	

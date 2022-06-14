import wollok.game.*

class Pantalla {
	
	var property image
	var property position = game.origin() 
	const property dimension
	const property sonido
	
	method cerrarPantalla() {keyboard.s().onPressDo{game.stop()}}
	method colisiona(personaje, unSonido){}
	
	method mostrarResultado(unSonido){
		game.clear()
		unSonido.detener()
		game.addVisual(self)
		sonido.reproducirAutomaticamente()
		sonido.reproducirSinParar()
		self.cerrarPantalla()
	}
}

class DimensionPantalla {
	
	const property alto
	const property ancho
}

class Sonido {
	
	var sonidoJuego
	
	method reproducir( )= sonidoJuego.play()
	method reproducirAutomaticamente() = game.schedule(1, {=> self.reproducir()})
	method reproducirSinParar() = sonidoJuego.shouldLoop(true)
	method detener() = sonidoJuego.stop()
	method bajarVolumen(cant) = sonidoJuego.volume(cant)
}
import wollok.game.*

class Juego {
	
	const portada
	const opciones
	const escenario
	const fondo
	const titulo
	
	method mostrarPortada(){
		
		self.configurarPantalla()
		self.agregarElementoAlJuego(portada)
		portada.cerrarPantalla()
		portada.sonido().reproducirAutomaticamente()
		portada.sonido().reproducirSinParar()
		keyboard.enter().onPressDo{self.mostrarPantallaConOpciones()}
	}
	
	method configurarPantalla(){
		
		game.height(portada.dimension().alto())
		game.width(portada.dimension().ancho())
		game.title(titulo)
		game.boardGround(fondo)
	}
	
	method agregarElementoAlJuego(algo) {game.addVisual(algo)}
	
	method mostrarPantallaConOpciones() {
		
		game.clear()
		self.agregarElementoAlJuego(opciones)
		opciones.cerrarPantalla()
		keyboard.num1().onPressDo{self.iniciarvideojuego(110000)}
		keyboard.num2().onPressDo{self.iniciarvideojuego(70000)}
		keyboard.num3().onPressDo{self.iniciarvideojuego(50000)}
	}
	
	method iniciarvideojuego(tiempo) {
		
		game.clear()
		opciones.sonido().reproducir()
		portada.sonido().detener()
		escenario.iniciar(tiempo)
	}
	
	
	
}

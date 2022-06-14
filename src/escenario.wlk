import wollok.game.*

class Escenario {
	
	const personajes = []
	const fondo
	const tiempoPartida
	const numerosEnPartida
	
	method iniciar(tiempo){
		
		self.agregarElementoEscenario(fondo)
		self.agregarPersonajesEnEscenario()
		self.habilitarDesplazammientoPersonajes()
		self.habilitarColisiones()
		fondo.cerrarPantalla()
		fondo.sonido().reproducirAutomaticamente()
		fondo.sonido().reproducirSinParar()
		fondo.sonido().bajarVolumen(0.5)
		self.iniciarReloj(tiempo)
	}
	
	method agregarElementoEscenario(algo) {game.addVisual(algo)}
	
	method eliminarElementoEscenario(algo) {game.removeVisual(algo)}
	
	method agregarPersonajesEnEscenario(){
		
		personajes.forEach({unPersonaje => 
			self.agregarElementoEscenario(unPersonaje)
			unPersonaje.habilitar()
		})
	}
	
	method habilitarDesplazammientoPersonajes() {personajes.forEach({unPersonaje => unPersonaje.moverse()})}
	
	method habilitarColisiones() {personajes.forEach({unPersonaje => unPersonaje.colisionaConEnemigo(fondo.sonido())})}
	
	method iniciarReloj(unTiempo) {
		
		tiempoPartida.miTiempoTotal(unTiempo)
		numerosEnPartida.generarDigitos(unTiempo/1000, tiempoPartida, game.at(17, 17))
		tiempoPartida.empezar(fondo.sonido())
	}

}

import wollok.game.*
import inicializaciones.*
import tableroTiempo.*

class Escenario {
	
	const personajes = []
	const image
	const tiempoReloj
	
	method iniciar(){
		
		self.agregar(image)
		self.agregarPersonajesAlJuego()
		self.desplazamientoPersonajes()
		self.colisiones()
		self.reloj()
		
	}
	
	method desplazamientoPersonajes(){
		personajes.forEach({unPersonaje => unPersonaje.desplazarse()})
	}
	
	method colisiones(){
		personajes.forEach({unPersonaje => unPersonaje.colisionaConEnemigo()})
	}
	
	method agregarPersonajesAlJuego(){
		personajes.forEach({unPersonaje => 
			self.agregar(unPersonaje)
			unPersonaje.agregar()
		})
	}
	
	method reloj(){
		const tiempo = new Tiempo(tiempoTotal = tiempoReloj, frecuencia = 1)
		const posicionReloj = game.at(10, 15)
		generarNumerosVisibles.generarDigitos(tiempoReloj / 1000, tiempo, posicionReloj)
		tiempo.empezar()
	}
	
	method eliminarPersonajesDelJuego(){
		personajes.forEach({unPersonaje => 
			if(unPersonaje.estoyAgregado()){
				unPersonaje.quitar()
				self.eliminar(unPersonaje)
			}		
		})
	}
	
	method agregar(algo) {game.addVisual(algo)}
	
	method eliminar(algo) {game.removeVisual(algo)}
	
}
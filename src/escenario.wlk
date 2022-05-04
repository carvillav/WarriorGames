import wollok.game.*
import tableroTiempo.*
import personaje.*
import guerrero.*
import enemigo.*
import fondo.*
import pantalla.*

class Escenario {
	
	const personajes = []
	const image
	const tiempoReloj
	const property pantallaDerrota
	const property sonidoAmbiente
	const property musicaDerrota
	
	method iniciar(){
		
		self.agregar(image)
		self.agregarPersonajesAlJuego()
		self.desplazamientoPersonajes()
		self.colisiones()
		self.reloj()
		self.cerrarPantalla()
		
		//reproduce automáticamente el sonido
        sonidoAmbiente.reproducirAutomaticamente()

        //entra en un loop el sonido después de haber terminado
        sonidoAmbiente.reproducirSinParar()
        
        //bajar volumen sonido
        sonidoAmbiente.bajarVolumen(0.5)
        
	}
	
	method desplazamientoPersonajes(){
		personajes.forEach({unPersonaje => unPersonaje.desplazarse()})
	}
	
	method colisiones(){
		personajes.forEach({unPersonaje => unPersonaje.colisionaConEnemigo(self)})
	}
	
	method agregarPersonajesAlJuego(){
		personajes.forEach({unPersonaje => 
			self.agregar(unPersonaje)
			unPersonaje.agregar()
		})
	}
	
	method reloj(){
		
		const tiempo = new Tiempo(tiempoTotal = tiempoReloj, 
			frecuencia = 1, 
			mensajeDerrota = pantallaDerrota, 
			escenarioAsociado = self, 
			musicaFinal = musicaDerrota
		)
		
		const posicionReloj = game.at(17, 17)
		
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
	
	method cerrarPantalla() {keyboard.s().onPressDo{game.stop()}}
	
	method mostrarPantallaResultadoDeLaPartida(resultado, musica){
		game.clear()
		sonidoAmbiente.detener()
		game.addVisual(resultado)
		musica.reproducirAutomaticamente()
		self.cerrarPantalla()
	}
	
}

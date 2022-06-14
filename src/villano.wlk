import wollok.game.*
import personaje.*

class Villano inherits Personaje{
	
	const property miDesplazamiento
	var cantidadDesaparecidas = 0
	var property soyJefeVillano = false
	
	override method moverse(){ miDesplazamiento.desplazarse(self) }
	
	method colisiona(personaje, unSonido){
		
		personaje.emitirMensaje("¡Uno Menos!")
		game.removeVisual(self)
		cantidadDesaparecidas++
		personaje.aumentaPoder(cantidadDesaparecidas)
		if(cantidadDesaparecidas < 3) game.addVisual(self)
	}
}

class VillanoPrincipal inherits Villano{
	
	var property poder
	const pantallaDerrota
	const pantallaVictoria
	
	override method colisiona(personaje, unSonido){
		
		if(poder < personaje.poder()){
			pantallaVictoria.mostrarResultado(unSonido)
		}else{
			pantallaDerrota.mostrarResultado(unSonido)
		}
	}
}
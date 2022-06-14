import wollok.game.*
import personaje.*

class PersonajePrincipal inherits Personaje{
	
	var property poder
	const misDesplazamientos = []
	
	override method image(){
		
		if(poder >= 7000 && poder < 13000) return "guerreroNegro.png"
		if(poder >= 13000) return "guerreroFinal.png"
		
		return "guerreroPrincipal.png"
	}
	
	method aumentaPoder(cantColisiones){
		poder += 500*cantColisiones
	}
	
	override method moverse(){
		misDesplazamientos.forEach({unDesplazamiento => unDesplazamiento.desplazarse(self)})
	}
	
	override method colisionaConEnemigo(unSonido){
		game.onCollideDo(self,{algo => algo.colisiona(self, unSonido)})
	}
}

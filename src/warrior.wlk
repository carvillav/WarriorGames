import wollok.game.*

class Warrior {
	var property position = null
	var property poder = 0
	var property estoyAgregado
	
	method image() {
		if(poder > 5000 && poder <= 10000){
			return "guerreroNegro.png"
		}
		if(poder > 10000){
			return "guerreroFinal.png"
		}
		return "guerreroPrincipal.png"
	}
	
	method moverALaDerecha(){
		position = position.right(1)
	}
	method moverALaIzquierda(){
		position = position.left(1)
	}
	method moverArriba(){
		position = position.up(1)
	}
	method moverAbajo(){
		position = position.down(1)
	}
	
	method aumentaPoder(cantColisiones){
		poder += 500*cantColisiones
	}
	
	method agregar(){estoyAgregado = true}
	method quitar() {estoyAgregado = false} 
}

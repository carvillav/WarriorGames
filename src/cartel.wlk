import wollok.game.*

class Cartel {
	
	const property personaje
	const property position
	
	method text() = "        Power: " + personaje.poder().toString()
	method colisiona(algo){}
	
}

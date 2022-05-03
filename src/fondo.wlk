import wollok.game.*

class Fondo {
	
	const property image 
	const property position = game.origin()

}

	//Fondos
	const pantallaInicial = new Fondo(image = "portadaInicial.jpg")
	const pantallaModoDeJuego = new Fondo(image = "modoDeJuego.jpg")
	const imagenEscenario = new Fondo(image = "suelo.jpg")
	const victoria = new Fondo(position = game.at(11,5), image = "you-win.png")
	const derrota = new Fondo(position = game.at(9,3), image = "game_over.png")
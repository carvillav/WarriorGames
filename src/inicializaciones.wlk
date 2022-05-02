import wollok.game.*
import enemigo.*
import guerrero.*
import cartel.*
import pantalla.*
import escenario.*

	//Enemigos
	const boss = new GirarEnSuLugar(image = "dragonNegro0.png", position = game.at(25,11), power = 13000)
	const enanoHechicero = new MoverseEnVertical(image = "enanoHechicero.png", position = game.at(1,15), posicionFija = game.at(1,15))
	const ladronZombie = new MoverseAleatoriamente(image = "ladronZombie.png", position = game.at(28,3))
	const basilisco = new MoverseEnHorizontal(image = "basilisco.png", position = game.at(19,9))
	const esqueleto = new Enemigo(image= "esqueleto.png",  position = game.at(13,4))
	
	//Guerrero
	const warrior = new Guerrero(position = game.at(3,5), poder = 1000, estoyAgregado = false)
	const textoPoderGuerrero = new Cartel(personaje = warrior, position = game.origin())
	
	//Fondos
	const pantallaInicial = new Fondo(image = "portadaInicial.jpg")
	const pantallaModoDeJuego = new Fondo(image = "modoDeJuego.jpg")
	const imagenEscenario = new Fondo(image = "suelo.jpg")
	
	//Niveles
	const escenario = new Escenario(
		personajes = [warrior, boss, enanoHechicero, ladronZombie, basilisco, esqueleto],
		image = imagenEscenario,
		tiempoReloj = 180000
	)
	
	//Pantalla
	const pantallaJuego = new Pantalla(alto = 18, ancho = 35, position = game.center(), titulo = "Warriors", image = "fondoNegro.jpg", escenarioPrincipal = escenario)
	
import wollok.game.*
import personajePrincipal.*
import villano.*
import pantalla.*
import juego.*
import escenario.*
import desplazamiento.*
import tiempo.*

class InstanciarWarriorGame {
	
	var sonidoInicial
	var sonidoOpciones
	var sonidoPartida
	var sonidoVictoria
	var sonidoDerrota
	const dimensionPantallaJuego = new DimensionPantalla(alto = 18, ancho = 35)
	var pantallaInicial
	var pantallaOpciones
	var pantallaEscenario
	var pantallaVictoria
	var pantallaDerrota
	var villanoEnanoHechicero
	var villanoBasilisco
	var villanoEsqueleto
	var villanoLadronZombie
	var villanoJefe
	var personajePrincipal
	var desplazamientoVertical
	var desplazamientoHorizontal
	var sinDesplazamiento
	var desplazamientoAleatorio
	var desplazamientoEnElLugar
	var desplazamientosPersonajePrincipal = []
	var personajesVideojuego = []
	var tiempo
	var escenarioVideojuego
	var warriorsGame
		
	method initialize(){
		// Sonidos
		sonidoInicial = self.crearSonido("musica/intro.mp3")
		sonidoOpciones = self.crearSonido("musica/seleccionar.mp3")
		sonidoPartida = self.crearSonido("musica/ambiente.mp3")
		sonidoVictoria = self.crearSonido("musica/victoria.mp3")
		sonidoDerrota = self.crearSonido("musica/derrota.mp3")
		// Pantallas
		pantallaInicial = self.crearPantalla("portadaInicial.jpg", game.origin(),sonidoInicial)
		pantallaOpciones = self.crearPantalla("modoDeJuego.jpg", game.origin(),sonidoOpciones)
		pantallaEscenario = self.crearPantalla("suelo.jpg", game.origin(),sonidoPartida)
		pantallaVictoria = self.crearPantalla("you-win.png", game.at(11, 5),sonidoVictoria)
		pantallaDerrota = self.crearPantalla("game_over.png", game.at(9, 3),sonidoDerrota)
		//Desplazamientos
		desplazamientoVertical = new DesplazarAutomaticamenteVertical(posicionFija = game.at(1, 15), dimensionDePantalla = dimensionPantallaJuego)
		desplazamientoHorizontal = new DesplazarAutomaticamenteHorizontal(dimensionDePantalla = dimensionPantallaJuego)
		sinDesplazamiento = new Desplazamiento(dimensionDePantalla = dimensionPantallaJuego)
		desplazamientoAleatorio = new DesplazamientoAleatorio(dimensionDePantalla = dimensionPantallaJuego)
		desplazamientoEnElLugar = new GirarEnSuPropioLugar(dimensionDePantalla = dimensionPantallaJuego)
		desplazamientosPersonajePrincipal = [
			new DesplazarDerecha(dimensionDePantalla = dimensionPantallaJuego),
			new DesplazarIzquierda(dimensionDePantalla = dimensionPantallaJuego),
			new DesplazarArriba(dimensionDePantalla = dimensionPantallaJuego),
			new DesplazarAbajo(dimensionDePantalla = dimensionPantallaJuego)
		]		
		//Villanos
		villanoEnanoHechicero = self.crearVillano(desplazamientoVertical, "enanoHechicero.png", game.at(1, 15))
		villanoBasilisco = self.crearVillano(desplazamientoHorizontal, "basilisco1.png", game.at(19, 9))
		villanoEsqueleto = self.crearVillano(sinDesplazamiento, "esqueleto.png", game.at(13, 4))
		villanoLadronZombie = self.crearVillano(desplazamientoAleatorio, "ladronZombie.png", game.at(28, 3))
		//Villano Final
		villanoJefe = new VillanoPrincipal(poder = 12500, miDesplazamiento = desplazamientoEnElLugar, image = "dragonNegro0.png", position = game.at(25, 11), pantallaDerrota = pantallaDerrota, pantallaVictoria = pantallaVictoria)
		//Personaje Principal
		personajePrincipal = self.crearPersonajePrincipal(1000, game.at(3, 5), desplazamientosPersonajePrincipal)
		//Tiempo
		tiempo = new Tiempo(frecuencia = 1, resultadoPartida = pantallaDerrota)
		//Escenario
		personajesVideojuego = [personajePrincipal, villanoEnanoHechicero, villanoBasilisco, villanoEsqueleto, villanoJefe, villanoLadronZombie]
		escenarioVideojuego = new Escenario(fondo = pantallaEscenario, personajes = personajesVideojuego, tiempoPartida = tiempo, numerosEnPartida = new GenerarNumerosVisibles())
		//Juego
		warriorsGame = new Juego(portada = pantallaInicial, titulo = "Warriors Game", opciones = pantallaOpciones, escenario = escenarioVideojuego, fondo = "fondoNegro.jpg")
		warriorsGame.mostrarPortada()
	}
	
	method crearSonido(unaDireccionDeSonido) = new Sonido(sonidoJuego = game.sound(unaDireccionDeSonido))
	method crearPantalla(unaImagen, unaPosicion, unSonido) = new Pantalla(image = unaImagen, position = unaPosicion, dimension = dimensionPantallaJuego, sonido = unSonido)
	method crearVillano(unDesplazamiento, unaImagen, unaPosicion) = new Villano(miDesplazamiento = unDesplazamiento, image = unaImagen, position = unaPosicion)
	method crearPersonajePrincipal(unPoder, unaPosicion, listaDesplazamientos) = new PersonajePrincipal(poder = unPoder, position = unaPosicion, misDesplazamientos = listaDesplazamientos)
	
}


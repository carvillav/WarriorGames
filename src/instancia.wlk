import wollok.game.*
import personajePrincipal.*
import villano.*
import pantalla.*
import juego.*
import escenario.*
import desplazamiento.*
import tiempo.*

//Sonidos
const sonidoInicial = new Sonido(sonidoJuego = game.sound("musica/intro.mp3"))
const sonidoOpciones = new Sonido(sonidoJuego = game.sound("musica/seleccionar.mp3"))
const sonidoPartida = new Sonido(sonidoJuego = game.sound("musica/ambiente.mp3"))
const sonidoVictoria = new Sonido(sonidoJuego = game.sound("musica/victoria.mp3"))
const sonidoDerrota = new Sonido(sonidoJuego = game.sound("musica/derrota.mp3"))

//Pantallas
const dimensionPantallaJuego = new DimensionPantalla(alto = 18, ancho = 35)
const pantallaInicial = new Pantalla(image = "portadaInicial.jpg", dimension = dimensionPantallaJuego, sonido = sonidoInicial)
const pantallaOpciones = new Pantalla(image = "modoDeJuego.jpg", dimension = dimensionPantallaJuego, sonido = sonidoOpciones)
const pantallaEscenario = new Pantalla(image = "suelo.jpg", dimension = dimensionPantallaJuego, sonido = sonidoPartida)
const pantallaVictoria = new Pantalla(image = "you-win.png", position = game.at(11,5), dimension = dimensionPantallaJuego, sonido = sonidoVictoria)
const pantallaDerrota = new Pantalla(image = "game_over.png", position = game.at(9,3), dimension = dimensionPantallaJuego, sonido = sonidoDerrota)

//Desplazamientos
const desplazamientoVertical = new DesplazarAutomaticamentaVertical(posicionFija = game.at(1,15), dimensionDePantalla = dimensionPantallaJuego)
const desplazamientoHorizontal = new DesplazarAutomaticamenteHorizontal(dimensionDePantalla = dimensionPantallaJuego)
const sinDesplazamiento = new Desplazamiento(dimensionDePantalla = dimensionPantallaJuego)
const desplazamientoAleatorio = new DesplazamientoAleatorio(dimensionDePantalla = dimensionPantallaJuego)
const desplazamientoEnElLugar = new GirarEnSuPropioLugar(dimensionDePantalla = dimensionPantallaJuego)
const desplazamientoHaciaLaDerecha = new DesplazarDerecha(dimensionDePantalla = dimensionPantallaJuego)
const desplazamientoHaciaLaIzquierda = new DesplazarIzquierda(dimensionDePantalla = dimensionPantallaJuego)
const desplazamientoHaciaArriba = new DesplazarArriba(dimensionDePantalla = dimensionPantallaJuego)
const desplazamientoHaciaAbajo = new DesplazarAbajo(dimensionDePantalla = dimensionPantallaJuego)

const desplazamientosPersonajePrincipal = [desplazamientoHaciaLaDerecha, desplazamientoHaciaLaIzquierda, desplazamientoHaciaArriba, desplazamientoHaciaAbajo]

//Personajes
const personajePrincipal = new PersonajePrincipal(poder = 1000,  position = game.at(3,5), misDesplazamientos = desplazamientosPersonajePrincipal)
const villanoEnanoHechicero = new Villano(miDesplazamiento = desplazamientoVertical, image = "enanoHechicero.png", position = game.at(1,15))
const villanoBasilisco = new Villano(miDesplazamiento = desplazamientoHorizontal, image = "basilisco1.png", position = game.at(19,9))
const villanoEsqueleto = new Villano(miDesplazamiento = sinDesplazamiento, image= "esqueleto.png", position = game.at(13,4))
const villanoLadronZombie = new Villano(miDesplazamiento = desplazamientoAleatorio, image = "ladronZombie.png", position = game.at(28,3))
const villanoJefe = new VillanoPrincipal(poder = 12500, miDesplazamiento = desplazamientoEnElLugar, image = "dragonNegro0.png", 
	position = game.at(25,11), pantallaDerrota = pantallaDerrota, pantallaVictoria = pantallaVictoria
)

const personajesVideojuego = [personajePrincipal, villanoEnanoHechicero, villanoBasilisco, villanoEsqueleto, villanoJefe, villanoLadronZombie]

const tiempo = new Tiempo(frecuencia = 1, resultadoPartida = pantallaDerrota)
//const numerosVisibles = new GenerarNumerosVisibles()
const escenarioVideojuego = new Escenario(fondo = pantallaEscenario, personajes = personajesVideojuego, tiempoPartida = tiempo, 
	numerosEnPartida = new GenerarNumerosVisibles() //numerosVisibles
)

const warriorsGame = new Juego(portada = pantallaInicial, titulo = "Warriors Game", opciones = pantallaOpciones, 
	escenario = escenarioVideojuego, fondo = "fondoNegro.jpg"
)
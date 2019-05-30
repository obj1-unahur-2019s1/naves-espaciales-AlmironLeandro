class NaveEspacial {

	var property velocidad = 0
	var direccion = 0
	var combustible
	method cargarCombustible(cargar){
		combustible+=cargar
		
	}
	method descargarCombustible(cuanto){
		combustible-=cuanto
	}

	method velocidad(cuanto) {
		velocidad = cuanto
	}

	method acelerar(cuanto) {
		velocidad = (velocidad + cuanto).min(100000)
	}

	method desacelerar(cuanto) {
		(velocidad -= cuanto).max(1)
	}

	method irHaciaElSol() {
		direccion = 10
	}

	method escaparDelSol() {
		direccion = -10
	}

	method ponerseParaleloAlSol() {
		direccion = 0
	}

	method acercarseUnPocoAlSol() {
		direccion += 1
	}

	method alejarseUnPocoDelSol() {
		direccion -= 1
	}
	method prepararViaje(){
		combustible+=30000
		self.acelerar(5000)
	}

}

class NavesBaliza inherits NaveEspacial {

	var property colorDeBaliza = "verde"

	method escapar() {
		self.irHaciaElSol()
	}

	method avisar() {
		colorDeBaliza = "rojo"
	}

	method recibirAmenaza() {
		self.escapar()
		self.avisar()
	}

	method cambiarColorDeBaliza(colorNuevo) {
		colorDeBaliza = colorNuevo
	}

	override method prepararViaje() {
		super()
		colorDeBaliza = "verde"
		self.ponerseParaleloAlSol()
	}

}

class NavesPasajeros inherits NaveEspacial {

	var property cantidadPasajeros
	var property racionesDeComida = 0
	var property racionesDeBebida = 0
	
	
	method escapar() {
		self.acelerar(velocidad)
	}

	method avisar() {
		self.cargarRacionesDeComida(1 * cantidadPasajeros)
		self.cargarRacionesDeBebida(2 * cantidadPasajeros)
	}

	method recibirAmenaza() {
		self.escapar()
		self.avisar()
	}

  override	method prepararViaje() {
  		super()
		racionesDeComida += cantidadPasajeros * 4
		racionesDeBebida += cantidadPasajeros * 6
		self.acercarseUnPocoAlSol()
	}

	method cargarRacionesDeBebida(cuantas) {
		racionesDeBebida += cuantas
	}

	method cargarRacionesDeComida(cuantas) {
		racionesDeComida += cuantas
	}

	method descargarRacionesDeComida(cuantas) {
		racionesDeComida = (racionesDeComida - cuantas).max(0)
	}

}

class NavesCombate inherits NaveEspacial {

	var property estaInvisible = true
	var property misilesDesplegados = false
	var property mensajesEmitidos = []
	
	method escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
		
	}
	method avisar(){
		self.emitirMensaje("Amenaza recibida")
	}
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	override	method prepararViaje() {
  		super()
		estaInvisible = false
		misilesDesplegados = true
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
	}

	method ponerseVisible() {
		estaInvisible = false
	}

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}

	method primerMensajeEmitido() {
		return mensajesEmitidos.first()
	}

	method emitioMensaje(mensaje) {
		return mensajesEmitidos.contains(mensaje)
	}

	method esEscueta() {
		return not mensajesEmitidos.any({ mensaje => mensaje.size() >= 30})
	}

}
class NaveHospital inherits NavesPasajeros{
	var property quirofanosPreaparados=true
	method prepararQuirofanos(){
		quirofanosPreaparados=true
	}
	override method recibirAmenaza(){
		super()
		self.prepararQuirofanos()
	}
}

class NaveDeCombateSigilosa inherits NavesCombate{
	override method escapar(){
		//self.desplegarMisiles()
		//self.ponerseInvisible()
	}
}
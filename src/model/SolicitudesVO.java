package model;

// Clase que representa la tabla solicitudes de la base de datos
public class SolicitudesVO {	
	
	private String nombre;
	
	// constructor
	
	public SolicitudesVO (String _nombre) {
		this.nombre = _nombre;
	}
	
	// getters
	
	public String getNombre() {
		return nombre;
	}
	
	// setters
	
	public void setNombre(String _nombre) {
		this.nombre = _nombre;
	}
	
}

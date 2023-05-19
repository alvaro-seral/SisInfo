package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.SolicitudesEspecialesDAO;
import model.SolicitudesVO;

/*
 * Servlet encargado de cargar los datos necesarios para mostrar la página con la lista de solicitudes existentes
 */

/**
 * Servlet implementation class Especiales
 */
@WebServlet("/Especiales")
public class Especiales extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Especiales() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Establece el atributo de sesión 'especiales' incluyendo todas las solicitudes existentes 
		SolicitudesEspecialesDAO dao = new SolicitudesEspecialesDAO();
		ArrayList<SolicitudesVO> especiales = dao.obtenerSolicitudes();
		request.getSession().setAttribute("especiales", especiales);
		
		// Reenvía a la página con la lista de solicitudes
		request.getRequestDispatcher("GestionarEspeciales.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.UsuariosVO"%>
<%@ page import="model.EventosVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.time.LocalDate"%>

<% UsuariosVO usuario = (UsuariosVO)request.getSession().getAttribute("usuario"); 
   ArrayList<String> gruposUsuario = (ArrayList<String>)request.getSession().getAttribute("gruposUsuario"); 
   String grupoActual = (String)request.getSession().getAttribute("grupoActual");
   ArrayList<String> nomGrupos = (ArrayList<String>)request.getSession().getAttribute("nomGrupos");
   ArrayList<Boolean> boolGrupos = (ArrayList<Boolean>)request.getSession().getAttribute("boolGrupos"); %>
   
<% String start = request.getParameter("start");
   String end = request.getParameter("end");
   if (start==null) start="1";   
   if (end==null) end="7";
   int startAsInt = new Integer(start);
   int endAsInt = new Integer(end);
   
   ArrayList<EventosVO> eventos = (ArrayList<EventosVO>)request.getSession().getAttribute("eventos");
   ArrayList<Boolean> apuntados = (ArrayList<Boolean>)request.getSession().getAttribute("apuntados");
   String orden = (String)request.getSession().getAttribute("orden");
%>

<!DOCTYPE html>
<html lang="es">

<head>
	<meta charset="UTF-8">
	<title>Eventos</title>
	
    <!-- Estilos css propios -->
    <link href="estilo.css" rel="stylesheet">
	<!-- Estilos css bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>

<body id="page-top" class="bg-dark">

    <!-- Barra superior -->
    <nav class="mb-2 bg-light shadow">
	    <div class="d-flex flex-xl-row flex-column justify-content-between align-items-center">
	    	<!-- Logo -->
	        <div class="mx-2 my-1">
	            <img src="logo.png" alt="Social Music" style="max-width:16rem">
	        </div>
	        
	        <div class="d-flex flex-sm-row flex-column justify-content-between align-items-center">
	        	<!-- Cambiar grupo actual -->
	            <form action="CambiarGrupoActual" method="post">
	            	<div class="mx-4 my-2">
	                 <select id="cambiarGrupoActual" name="cambiarGrupoActual" class="btn btn-normal rounded-5" onchange="this.form.submit()">
	                 	<option selected hidden> <%= grupoActual %> </option>
	                 	<% for (String i:gruposUsuario) { %>
	                     <option class="sel-opt" value="<%= i %>"> <%= i %> </option>
	                     <% } %>
	                 </select>
	            	</div>
	            </form>
	            <!-- Gestionar grupos -->
	            <div class="mx-4 my-2">
	                <a href="Grupos.jsp" class="btn btn-normal rounded-5"> Gestionar grupos </a>
	            </div>
	        </div>
	        
	        <!-- Menú desplegable -->
	        <div class="ml-2">
	            <div class="drop-down">
	                <button type="button" class="btn btn-menu rounded-0"> 
	                	<%= usuario.getNombre() %> <br> <sup> Usuario <%= usuario.getTipo() %> </sup>
	                </button>
	                <div class="drop-down-content justify-content-center">
		                <div class="px-3 my-3">
							<button class="btn btn-normal rounded-5" type="button" data-toggle="modal" data-target="#informar"> Informar administrador </button>
		                </div>
		                <% if (usuario.getTipo().equals("Normal")) { %>
	                    <div class="px-3 my-3">
	                    	<button class="btn btn-normal rounded-5" type="button" data-toggle="modal" data-target="#solicitar"> Solicitar cuenta especial </button>
	                    </div>
	                    <% } %>
	                    <div class="px-3 my-3">
	                        <a class="btn btn-normal rounded-5" href="eliminar.jsp"> Eliminar cuenta </a>
	                    </div>
	                    <div class="px-3 my-3">
	                        <button class="btn btn-normal rounded-5" type="button" data-toggle="modal" data-target="#cerrar"> Cerrar sesión </button>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</nav>
	
	<!-- Cuerpo -->
	<div class="row my-4 mx-2 justify-content-center">
	                
	    <!-- Izquierda -->
	    <div class="col-3">
		    <div class="card shadow px-4 mb-4">
		    	<div class="card-body">
		    		<div class="row">
			    		<form action="Ordenar" method="post"> 
			    			<div class="col">
			    				<h5> Ordenar por: </h5>
			    			</div>
			    			<div class="col">
				    			<div class="form-check">
			    					<input id="porFecha" class="form-check-input" type="radio" name="filtro" value="porFecha" <% if (orden.equals("porFecha")) { %> checked <% } %> onchange="this.form.submit()">
			    					<label for="porFecha" class="form-check-label"> Más nuevos </label>
			    				</div>
			    				<div class="form-check">
			    					<input id="porApuntados" class="form-check-input" type="radio" name="filtro" value="porApuntados" <% if (orden.equals("porApuntados")) { %> checked <% } %> onchange="this.form.submit()">
			    					<label for="porApuntados" class="form-check-label"> Más apuntados </label>
			    				</div>
			    			</div>
			    		</form>
		    		</div>
			    </div>
		    </div>
		</div>
		
	    <!-- Centro -->
	    <div class="col-6">
	    
	    	<!-- Elección: Publicaciones y eventos -->
	        <div class="card shadow px-2 mb-4">
	            <div class="card-body" style="display:inline-block">
	                <div class="row text-center" >
	                	<form class="col" action="MostrarPublicaciones" method="post">
	                    	<input class="btn btn-no-sel rounded-5 mx-2 my-1" required type="submit" value="Publicaciones">
	                    </form>
	                    <form class="col" action="IniciarEventos" method="post">
	                    	<input class="btn btn-sel rounded-5 mx-2 my-1" required type="submit" value="Eventos">
	                    </form>
	                </div>
	            </div>
	        </div>
	        
	        <!-- Listado eventos -->
	        <div class="card shadow px-2 my-4">
	        	<% int count=0; 
	        	   if (eventos.size() > 0) { %>
		        	<% for (EventosVO e:eventos) { 
		        	       count++; %>
			        	<div id="<%= e.getId() %>" class="mx-5 my-4">
			        		<h4> <%= e.getEmpresa() %> </h4>	
			        		<div class="row">
			        			<% LocalDate fecha = e.getFechaEvento().toLocalDate(); %>
			        			<div class="col-4">
			        				<p> Fecha: <%= fecha.getDayOfMonth() %> / <%= fecha.getMonthValue() %> / <%= fecha.getYear() %> </p>
			        			</div>
			        			<div class="col">
			        				<p> Lugar: <%= e.getLugar() %> </p>
			        			</div>
			        		</div>
			        		<p> <%= e.getDescripcion() %> </p>
			        		<div class="row">
			        			<div class="col-4">
			        				<a href="MostrarComentariosE?eventoActual=<%=e.getId()%>" class="btn btn-com rounded-5"> Comentarios </a>
			        			</div>
			        			<div class="col d-flex flex-row align-items-center">
			        				<% if (apuntados.get(count-1) == true) { %>
			        					<a href="Apuntarse?accion=no&eventoActual=<%=e.getId()%>&start=<%=start%>&end=<%=end%>" class="btn btn-ap rounded-5"> ¡Me apunto! </a>
			        				<% } else { %>
			        					<a href="Apuntarse?accion=si&eventoActual=<%=e.getId()%>&start=<%=start%>&end=<%=end%>" class="btn btn-no-ap rounded-5"> ¿Te apuntas? </a>
			        				<% } %>
			        				<p> &nbsp;&nbsp;&nbsp;&nbsp; <%= e.getNumApuntados() %> personas quieren ir </p>
			        			</div>
			        		</div>
			        	</div>
				        <% if (eventos.get(eventos.size()-1).getId() != e.getId()) { %>
				        	<hr class="mx-3">
				        <% } %>
		        	<% } %>
		        <% } else { %>
		        	<div class="mx-5 mt-4 text-center">
		        		<p><i> No hay eventos que mostrar... </i></p>
		        	</div>
		        <% } %>
	        </div>
	        
	        <!-- Páginas anterior y posterior -->
	        <div class="row my-4 justify-content-center">
	        	<div class="col">
	        		<div class="card shadow px-2 mb-4">
	        			<div style="text-align:center" class="card-body">
	        				<a <% if (startAsInt>1) { %> href="MostrarEventos?start=<%=startAsInt-endAsInt%>&end=<%=endAsInt%>" <% } %> > 
	        					<button class="btn btn-peq-s rounded-5 my-1" <% if (startAsInt==1) { %> disabled <% } %> > &lt;- </button> 
	        				</a>
	        			</div>
	        		</div>
	        	</div>
	        	<div class="col"></div>
	        	<div class="col">
	        		<div class="card shadow px-2 mb-4">
	        			<div style="text-align:center" class="card-body">
	        				<a <% if (endAsInt==count) { %> href="MostrarEventos?start=<%=startAsInt+endAsInt%>&end=<%=endAsInt%>" <% } %> > 
	        					<button class="btn btn-peq-s rounded-5 my-1" <% if (endAsInt>count) { %> disabled <% } %> > -&gt; </button> 
	        				</a>
	        			</div>
	        		</div>
	        	</div>
	        </div>
	    </div>
	
	    <!-- Derecha -->
	    <div class="col-3">
	    	<% if (usuario.getTipo().equals("Especial")) { %>
		    	<div class="card shadow px-2 mb-4">
		            <div class="card-body text-center">
                    	<button class="btn btn-si rounded-5 mx-2 my-1" type="button" data-toggle="modal" data-target="#realizarEvento"> Realizar evento </button>
		            </div>
		        </div>
			<% } %>
	    </div>
	</div>
	
	<!-- Gestionar grupos -->    
    <div class="modal fade" id="gestionar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-2"> Informar administrador </h5>
                </div>
                <form action="GestionarGrupos" method="post">
	                <div class="modal-body">
	                    <p class="mx-2"> Únete a nuevos grupos o sal de aquellos a los que perteneces: </p>
	                    <div class="form-control rounded-3" style="height: 10rem; overflow:auto;">
                        	<% String aux = "";
                        	for (int i=0; i<nomGrupos.size(); i++) { 
                        		aux=nomGrupos.get(i); %>
                        		<% if (boolGrupos.get(i)==true) { %>
								<input class="form-check-input mx-3 mb-3 check" checked type="checkbox" name="grupos" value="<%= aux %>"> 
								<% } else { %>
								<input class="form-check-input mx-3 mb-3 check" type="checkbox" name="grupos" value="<%= aux %>"> 
								<% } %>
								<label class="form-check-label" for="flexCheckDefault"> <%= aux %> </label> <br>
							<% } %>
                        </div>
	                    <div class="my-4 px-2 text-center">
	                        <button type="button" class="btn btn-peq-n rounded-5 mx-3" data-dismiss="modal"> Cancelar </button>
	                        <input class="btn btn-peq-s rounded-5 mx-3" required type="submit" value="Guardar">
	                    </div>
	                </div>
	            </form>
            </div>
        </div>
    </div>

	<!-- Informar administrador -->    
    <div class="modal fade" id="informar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-2"> Informar administrador </h5>
                </div>
                <form action="InformarAdministrador" method="post">
	                <div class="modal-body">
	                    <p class="mx-2"> Redacta y envía información, propuestas o quejas relativas a Social Music Unlimited: </p>
	                    <div class="px-2">
	                        <input class="form-control rounded-3" required type="text" name="texto" placeholder="Escribe aquí...">
	                    </div>
	                    <div class="my-4 px-2 text-center">
	                        <button type="button" class="btn btn-peq-n rounded-5 mx-3" data-dismiss="modal"> Cancelar </button>
	                        <input class="btn btn-peq-s rounded-5 mx-3" required type="submit" value="Enviar">
	                    </div>
	                </div>
	            </form>
            </div>
        </div>
    </div>
    
    <!-- Solicitar cuenta especial -->    
    <div class="modal fade" id="solicitar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-2"> Solicitar cuenta especial </h5>
                </div>
                <form action="SolicitarEspecial" method="post">
                    <div class="modal-body">
                    	<p class="mx-2"> ¿Deseas enviar una solicitud para obtener el privilegio de publicar eventos? </p>
	                    <div class="my-4 px-2 text-center">
	                        <button type="button" class="btn btn-peq-n rounded-5 mx-3" data-dismiss="modal"> Cancelar </button>
	                        <input class="btn btn-peq-s rounded-5 mx-3" required type="submit" value="Confirmar">
	                    </div>
	                </div>
	            </form>
            </div>
        </div>
    </div>
    
    <!-- Cerrar sesión -->    
    <div class="modal fade" id="cerrar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-2"> Cerrar sesión </h5>
                </div>
                <form action="CerrarSesion" method="post">
                    <div class="modal-body">
                    	<p class="mx-2"> ¿Deseas cerrar la sesión actual de la cuenta? </p>
	                    <div class="my-4 px-2 text-center">
	                        <button type="button" class="btn btn-peq-n rounded-5 mx-3" data-dismiss="modal"> Cancelar </button>
	                        <input class="btn btn-peq-s rounded-5 mx-3" required type="submit" value="Confirmar">
	                    </div>
	                </div>
	            </form>
            </div>
        </div>
    </div>
    
    <!-- Realizar evento -->    
    <div class="modal fade" id="realizarEvento" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title mx-2"> Realizar evento </h5>
                </div>
                <form action="SubirEvento" method="post">
                    <div class="modal-body">
                    	<div class="mx-2 my-4 row">
						    <label for="inputQuien" class="col-3 col-form-label">¿Quién?</label>
						    <div class="col">
						    	<input required type="text" class="form-control rounded-3" id="inputQuien" name="empresa" placeholder="Empresa organizadora">
						    </div>
						</div>
						<div class="mx-2 my-4 row">
						    <label for="inputCuando" class="col-3 col-form-label">¿Cuándo?</label>
						    <div class="col">
						    	<input required type="date" class="form-control rounded-3" id="inputCuando" name="fecha">
						    </div>
						</div>
						<div class="mx-2 my-4 row">
						    <label for="inputDonde" class="col-3 col-form-label">¿Dónde?</label>
						    <div class="col">
						    	<input required type="text" class="form-control rounded-3" id="inputDonde" name="lugar" placeholder="Lugar">
						    </div>
						</div>
						<div class="mx-2 my-4 row">
						    <label for="inputQue">¿Qué?</label>
						    <div class="col mt-2">
						    	<input required type="text" class="form-control rounded-3" id="inputQue" name="descripcion" placeholder="Descripción">
						    </div>
						</div>
	                    <div class="my-4 px-2 text-center">
	                        <button type="button" class="btn btn-peq-n rounded-5 mx-3" data-dismiss="modal"> Cancelar </button>
	                        <input class="btn btn-peq-s rounded-5 mx-3" required type="submit" value="Publicar">
	                    </div>
	                </div>
	            </form>
            </div>
        </div>
    </div>
        
	<!-- Scripts js bootstrap -->
	<script src="jquery.min.js"></script>
    <script src="bootstrap.bundle.min.js"></script>
</body>
</html>
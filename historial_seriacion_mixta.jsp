<%--
=====================================================
    PAGINA: seriacion_mod_mixta — [Historial de Seriaciones Modalidad Mixta]
=====================================================
    Descripcion: [Pantalla de consulta de seriaciones registradas para la modalidad mixta]
    Variables de sesion: usuario, clave_usuario
    Dependencias: Bootstrap 5.3.3, Font Awesome 6.4.0,
                  global/css/custom.css, css/custom.css
    @version 1.0
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(
            request.getContextPath() + "/jsp/login.jsp");
        return;
    }
    String nombre_usuario = String.valueOf(
        session.getAttribute("usuario"));
    int cve_persona = Integer.parseInt(
        String.valueOf(session.getAttribute("clave_usuario")));
%><!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Historial de Seriaciones</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/v2/comunes/global/css/custom.css">
    <link rel="stylesheet" href="css/custom.css?v=3.0">
</head>

<body class="bg-light d-flex flex-column min-vh-100">
    <jsp:include page="/v2/comunes/_menu/components/menu-horizontal.jsp" />
    <div class="header-title mb-4">
        <i class="fa-solid fa-calendar-week"></i>
        <div>
            <h1>Historial de Seriaciones Modalidad Mixta (DD)</h1>
            <p>Registro de seriaciones realizadas por periodo</p>
        </div>
    </div>
    <div>
        <div class="ms-4"> 
        <a href="seriacion_mod_mixta.jsp" class="btn btn-volver-verde fw-bold" style="border-radius: 6px;">
            <i class="fa-solid fa-arrow-left me-1"></i> Volver al Registro
        </a>
    </div>
    
    <div class="container-fluid mt-4 mb-5 px-4">
        <div class="card border-0 shadow-sm mx-auto" style="border-radius: 12px; max-width: 900px;">
            <div class="card-body p-4">

                <div id="historialMainContainer" class="mt-4">
                    <div id="vistaPeriodos" class="mx-auto">
                        <div class="input-group mb-3 shadow-sm" style="max-width: 300px;">
                            <span class="input-group-text bg-white border-end-0"><i
                                    class="fa-solid fa-magnifying-glass text-muted"></i></span>
                            <input type="text" id="inputBuscarPeriodo" class="form-control border-start-0 ps-0"
                                placeholder="Buscar por nombre de periodo">
                        </div>

                        <div id="listaCardsPeriodos" class="d-flex flex-column pe-2"
                            style="max-height: 300px; overflow-y: auto;"></div>
                    </div>

                    <div id="vistaDetallePeriodo" class="d-none">
                        <button id="btnVolverPeriodos" class="btn btn-sm btn-outline-secondary mb-3 shadow-sm">
                            <i class="fa-solid fa-arrow-left"></i> Volver a Periodos
                        </button>

                        <h4 id="tituloDetallePeriodo" class="fw-bold mb-3" style="color: #006666;"></h4>

                        <div id="listaCardsCarreras" class="d-flex flex-column gap-2"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    </div>

    <div class="modal fade" id="modalVerSeriacion" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header modal-header-azul">
                <h5 class="modal-title fw-bold" id="modalVerTitulo">Ingeniería en Mecatrónica - Cuatrimestre 1</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            
            <div class="modal-body bg-light">
                <div class="d-flex justify-content-end mb-3">
                    <div class="badge-actualizado px-3 py-2 bg-white text-dark border shadow-sm rounded">
                        <span class="text-muted">Actualizado por:</span> 
                        <span class="fw-bold" id="modalVerUsuario">Cargando...</span> 
                        <span class="text-muted" id="modalVerFecha"></span>
                    </div>
                </div>
                
                <div class="table-responsive bg-white shadow-sm rounded mb-4 p-2">
                    <table class="table table-hover mb-0 text-center align-middle" style="font-size: 0.9rem;">
                        <thead style="border-bottom: 2px solid #dee2e6;">
                            <tr>
                                <th class="text-start">Asignatura</th>
                                <th>Tipo de asignatura</th>
                                <th>Sem. Inicio</th>
                                <th>Sem. Fin</th>
                                <th>Sem. de Duración</th>
                                <th>Fecha Inicio</th>
                                <th>Fecha Fin</th>
                            </tr>
                        </thead>
                        <tbody id="tbodyModalMaterias">
                            </tbody>
                    </table>
                </div>

                <div class="d-flex justify-content-end mb-2 gap-3" style="font-size: 0.85rem;">
                    <span><i class="fa-solid fa-square" style="color: #f58220;"></i> Asignaturas Semipresenciales</span>
                    <span><i class="fa-solid fa-square" style="color: #8cc63f;"></i> Asignaturas Virtuales</span>
                </div>
                
                <div class="bg-white shadow-sm rounded p-3 overflow-auto">
                    <div id="modalVerGantt" style="min-width: 800px;">
                        </div>
                </div>
            </div>
            
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
    <% String footerUrl="/v2/comunes/_footer/footer.jsp" ; %>
        <jsp:include page="<%= footerUrl %>" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="<%=request.getContextPath()%>/v2/comunes/global/js/app.js"></script>

        <script src="js/app.js"></script>

</body>

</html>

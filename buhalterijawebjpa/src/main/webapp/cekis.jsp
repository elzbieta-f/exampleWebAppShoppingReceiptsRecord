<%@page import="javax.persistence.EntityManager"%>
<%@page import="lt.bit.buhalterijawebjpa.data.Cekis"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache");
%>
<%
    String idStr = request.getParameter("id");
    Cekis cekis = null;
    try {
        int id = Integer.parseInt(idStr);
        EntityManager em = (EntityManager) request.getAttribute("em");
        cekis = em.find(Cekis.class, id);
    } catch (Exception ex) {
        // ignored
    }
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <style>
            .link {
                text-decoration: none;
            }
            .btn-width {
                width: 100px;
            }
        </style>
        <title>Cekio ivedimas</title>
    </head>
    <body>
        <div class="bg-secondary">
            <h1 class="text-light p-3">Čekio įvedimas/redagavimas</h1>
        </div>
        <div class="container">

<!--            <div><%=cekis%></div>-->

            <form action="saveCekis" method="POST">
                <%if (cekis != null) {%>
                <input type="hidden" name="id" value="<%=cekis.getId()%>">
                <%}%>
                <div class="row">
                    <div class="mb-3 col-2">
                        <label for="data" class="form-label">Data:</label>
                    </div>
                    <div class="mb-3 col-6">
                        <input id="data" class="form-text" name="data" value="<%= cekis != null && cekis.getData() != null ? sdf.format(cekis.getData()) : ""%>">
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-2">
                        <label for="parduotuve" class="form-label">Parduotuvė:</label>
                    </div>
                    <div class="mb-3 col-6">
                        <input id="parduotuve" class="form-text" name="parduotuve" value="<%= cekis != null ? cekis.getParduotuve() : ""%>">
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-2">
                        <label for="komentaras" class="form-label">Komentaras:</label>
                    </div>
                    <div class="mb-3 col-6">
                        <input id="komentaras" class="form-text" name="komentaras" value="<%= cekis != null && cekis.getKomentaras() != null ? cekis.getKomentaras() : ""%>">
                    </div>
                </div>

                <div class="row">
                    <div class="mb-3 col-2">
                        <input type="submit" class="btn border border-3 border-success text-success btn-width" value="Išsaugoti">    
                    </div>
                    <div class="mb-3 btn border border-3 border-danger btn-width col-2" >
                        <a href="index.jsp" class="link text-danger">Atmesti</a>
                    </div>
                </div>
        </div>
    </body>
</html>

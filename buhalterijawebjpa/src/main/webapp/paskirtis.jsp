
<%@page import="lt.bit.buhalterijawebjpa.data.Paskirtis"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache");
%>
<%
    String idStr = request.getParameter("id");
    Paskirtis paskirtis = null;
    try {
        int id = Integer.parseInt(idStr);
        EntityManager em = (EntityManager) request.getAttribute("em");
        paskirtis = em.find(Paskirtis.class, id);
    } catch (Exception ex) {
        // ignored
    }

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
        <title>Paskirties ivedimas</title>
    </head>
    <body>
        <div class="bg-secondary">
            <h1 class="text-light p-3">Paskirties įvedimas/redagavimas</h1>
        </div>
        <div class="container">


            <form action="savePaskirtis" method="POST">
                <%if (paskirtis != null) {%>
                <input type="hidden" name="id" value="<%=paskirtis.getId()%>">
                <%}%>
                <div class="row">
                    <div class="mb-3 col-2">
                        <label for="pavadinimas" class="form-label">Paskirties pavadinimas:</label>
                    </div>
                    <div class="mb-3 col-6">
                        <input id="pavadinimas" class="form-text" name="pavadinimas" value="<%= paskirtis != null ? paskirtis.getPavadinimas() : ""%>">
                    </div>
                </div>

                <div class="row">
                    <div class="mb-3 col-2">
                        <input type="submit" class="btn border border-3 border-success text-success btn-width" value="Išsaugoti">    
                    </div>
                    <div class="mb-3 btn border border-3 border-danger btn-width col-2" >
                        <a href="paskirtys.jsp" class="link text-danger">Atmesti</a>
                    </div>
                </div>
        </div>
    </body>
</html>



<%@page import="lt.bit.buhalterijawebjpa.data.Paskirtis"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache");
%>
<%
    EntityManager em = (EntityManager) request.getAttribute("em");
    String filter = request.getParameter("filter");
    String qStr = "";
    if (filter != null) {
        qStr += " where p.pavadinimas like :filtras ";
    }
    Query pq = em.createQuery("select p from Paskirtis p " + qStr + "order by p.id");
    pq.setParameter("filtras", "%" + filter + "%");
    List<Paskirtis> paskirtys = pq.getResultList();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/9a66ff09af.js" crossorigin="anonymous"></script>
        <style>
            .link {
                text-decoration: none;
            }
            .mygtukas{
                width: 200px;
            }
        </style>
        <title>Paskirtys</title>
    </head>
    <body>
        <div class="container" style="width: 50%">
            <form class="p-3">
                <div class="row">              
                    <div class="mb-3 col-6">
                        <input class="form-control" id="filter" class="form-text" name="filter" placeholder="<%= filter != null ? filter : "Įveskite paskirties pavadinimą ar jo dalį"%>">
                    </div>
                    <div class="mb-3 col-2"> <input class="btn btn-secondary text-light" type="submit" value="Filtruoti">
                    </div>
                </div>
            </form>
            <h1>Paskirčių sąrašas:</h1>
            <a href="paskirtis.jsp" class="link"><div class="btn btn-info mygtukas">+ Naujas paskirtis</div></a>
            <table class="table table-striped table-hover">
                <thead class="table-light">
                <th>ID</th>
                <th>Pavadinimas</th>
                <th>Prekės</th>
                <th></th>
                <th></th>
                </thead>
                <tbody>
                    <%for (Paskirtis paskirtis : paskirtys) {%>
                    <tr>
                        <td>
                            <%=paskirtis.getId()%>
                        </td>
                        <td>
                            <%=paskirtis.getPavadinimas()%>
                        </td>
                        <td>
                            <a href="prekes.jsp?paskirtis_id=<%=paskirtis.getId()%>" class="link text-secondary"><i class="fas fa-shopping-cart"></i>
                            </a>
                        </td>

                        <td><a href="deletePaskirtis?id=<%=paskirtis.getId()%>" class="text-danger"><i class="fas fa-trash-alt"></i></a></td>
                        <td><a href="paskirtis.jsp?id=<%=paskirtis.getId()%>" class="text-info"><i class="fas fa-edit"></i></a></td>


                    </tr>
                    <%}%>
                </tbody>
            </table>
            <div>
                <a href="index.jsp" class="link"><div class="btn btn-success mygtukas">Č E K I A I</div></a></div>
        </div>
    </body>
</html>

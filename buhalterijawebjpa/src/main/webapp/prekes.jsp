



<%@page import="javax.persistence.Query"%>
<%@page import="lt.bit.buhalterijawebjpa.data.Preke"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="lt.bit.buhalterijawebjpa.data.Paskirtis"%>
<%@page import="lt.bit.buhalterijawebjpa.data.Cekis"%>
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
    String link = "";
    String filtras = request.getParameter("filter");
    Cekis cekis = null;
    Paskirtis paskirtis = null;
    if (request.getParameter("cekis_id") != null) {
        String cekisIdStr = request.getParameter("cekis_id");
        int cekisId = Integer.parseInt(cekisIdStr);
        cekis = em.find(Cekis.class, cekisId);

    }
    if (request.getParameter("paskirtis_id") != null) {
        String paskIdStr = request.getParameter("paskirtis_id");
        int paskirtisId = Integer.parseInt(paskIdStr);
        paskirtis = em.find(Paskirtis.class, paskirtisId);
    }
    List<Preke> prekes = null;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String header = "";
    String qStr="";
    
    if (cekis != null) {
        header += "iš " + sdf.format(cekis.getData()) + " čekio, gauto parduotuvėje " + cekis.getParduotuve();
        link += "&cekis_id=" + cekis.getId();
        qStr+="where cekis is :cekis ";
    }
    if (paskirtis != null) {
        header += " su paskirtimi " + paskirtis.getPavadinimas();
        link += "&pakirtis_id=" + paskirtis.getId();
        if (cekis==null){
            qStr+="where ";
        } else {
            qStr+="and ";
        }
        qStr+="paskirtis is :paskirtis ";
    }
       if (filtras != null) {
//        link = "filter=" + filtras; 
          qStr+="where p.preke like :filtras ";
    }
    Query q = em.createQuery("select p from Preke p "+qStr+"order by p.id");
    if (cekis!=null){
        q.setParameter("cekis", cekis);
    }
    if (paskirtis!=null){
        q.setParameter("paskirtis", paskirtis);
    }
    if (filtras != null) {
    q.setParameter("filtras", "%" + filter + "%");
    }
    prekes = q.getResultList();

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
                width: 150px;
            }
        </style>
        <title>Prekes</title>
    </head>
    <body>
        <div class="container" style="width: 50%">
            <form class="p-3">
                <div class="row">              
                    <div class="mb-3 col-6">
                        <input class="form-control" id="filter" class="form-text" name="filter" placeholder="<%= filtras != null ? filtras : "Įveskite prekės pavadinimą ar jo dalį"%>">
                    </div>
                    <div class="mb-3 col-2"> <input class="btn btn-secondary text-light" type="submit" value="Filtruoti">
                    </div>
                </div>
            </form>

            <h2>Prekių sąrašas <%=header%></h2>
            <a href="preke.jsp?<%=link%>" class="link"><div class="btn btn-info mygtukas">+ Nauja prekė</div></a>
            <%if (prekes == null) {%>
            <<h2>Nėra prekių</h2>
                <%} else {%>
            <table class="table table-striped table-hover">
                <thead class="table-light">
                <th>ID</th>
                <th>Prekė</th>
                <th>Suma</th>
                <th>Paskirtis</th>
                <th>Čekis</th>
                <th></th>
                <th></th>
                </thead>
                <tbody>
                    <%for (Preke preke : prekes) {%>
                    <tr>
                        <td>
                            <%=preke.getId()%>
                        </td>
                        <td>
                            <%=preke.getPreke()%>
                        </td>
                        <td>
                            <%=preke.getSuma()%>
                        </td>
                        <td>
                            <a href="prekes.jsp?paskirtis_id=<%=preke.getPaskirtis().getId()%><%=link%>" class="text-info link"><%=preke.getPaskirtis().getPavadinimas()%></a>
                        </td>
                        <td>
                            <a href="prekes.jsp?cekis_id=<%=preke.getCekis().getId()%>" class="text-info link"><%=preke.getCekis().getParduotuve()%> <%=sdf.format(preke.getCekis().getData())%></a>
                        </td>

                        <td><a href="deletePreke?id=<%=preke.getId()%>" class="text-danger"><i class="fas fa-trash-alt"></i></a></td>
                        <td><a href="preke.jsp?id=<%=preke.getId()%><%=link%>" class="text-info"><i class="fas fa-edit"></i></a></td>


                    </tr>
                    <%}%>
                </tbody>
            </table>
            <%}%>
            <div>
                <a href="prekes.jsp" class="link"><div class="btn btn-success mygtukas m-3">Visos prekes</div></a></div>
            <div>
                <a href="paskirtys.jsp" class="link"><div class="btn btn-success mygtukas m-3">PASKIRTYS</div></a></div>
            <div>
                <a href="index.jsp" class="link"><div class="btn btn-success mygtukas m-3">Čekiai</div></a></div>
        </div>
    </body>
</html>

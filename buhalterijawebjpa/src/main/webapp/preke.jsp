
<%@page import="javax.persistence.Query"%>
<%@page import="lt.bit.buhalterijawebjpa.data.Preke"%>
<%@page import="lt.bit.buhalterijawebjpa.data.Paskirtis"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="lt.bit.buhalterijawebjpa.data.Cekis"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache");
%>
<%  EntityManager em = (EntityManager) request.getAttribute("em");
    String cekisIdStr = request.getParameter("cekis_id");
    Cekis cekis = null;
    try {
        int id = Integer.parseInt(cekisIdStr);
        cekis = em.find(Cekis.class, id);
    } catch (Exception ex) {
        // ignored
    }

    String paskIdStr = request.getParameter("paskirtis_id");
    Paskirtis paskirtis = null;
    try {
        int paskId = Integer.parseInt(paskIdStr);
        paskirtis = em.find(Paskirtis.class, paskId);
    } catch (Exception ex) {
        // ignored
    }

    String idStr = request.getParameter("id");
    Preke preke = null;
    try {
        int id = Integer.parseInt(idStr);
        preke = em.find(Preke.class, id);
    } catch (Exception ex) {
        // ignored
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String header = "";
    String link = "";
    if (cekis != null) {
        header += "iš " + sdf.format(cekis.getData()) + " čekio, gauto parduotuvėje " + cekis.getParduotuve();
        link += "&cekis_id=" + cekis.getId();
    }
    if (paskirtis != null) {
        header += " su paskirtimi " + paskirtis.getPavadinimas();
        link += "&pakirtis_id=" + paskirtis.getId();
    }
    Query cq = em.createQuery("select c from Cekis c order by c.id");
    List<Cekis> cekiai = cq.getResultList();
    Query pq=em.createQuery("select p from Paskirtis p order by p.id");
    List<Paskirtis> paskirtys = pq.getResultList();
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
            <h1 class="text-light p-3">Prekės įvedimas/redagavimas <%=header%></h1>
        </div>
        <div class="container">


            <form action="savePreke" method="POST">
                <%if (preke != null) {%>
                <input type="hidden" name="id" value="<%=preke.getId()%>">
                <%}%>
                <div class="row">
                    <div class="mb-3 col-2">
                        <label for="cekis_id">Pasirinkite čekį:</label></div>
                    <div class="mb-3 col-6">
                        <select class="form-select" id="cekis_id" name="cekis_id">
                            <% for (Cekis c : cekiai) {
                                    if ((preke != null && preke.getCekis().equals(c)) || (cekis != null && cekis.getId() == c.getId())) {%>
                            <option selected value="<%=c.getId()%>"><%=c.getId()%>. <%=c.getParduotuve()%>, <%=sdf.format(c.getData())%> </option>
                            <%} else {%>
                            <option value="<%=c.getId()%>">id: <%=c.getId()%> Parduotuvė :<%=c.getParduotuve()%> Data:<%=sdf.format(c.getData())%> </option>    
                            <%;
                                    }
                                }%>  
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-2">
                        <label for="preke" class="form-label">Prekė:</label>
                    </div>
                    <div class="mb-3 col-6">
                        <input class="form-control" id="preke" class="form-text" name="preke" value="<%= preke != null ? preke.getPreke() : ""%>">
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-2">
                        <label for="suma" class="form-label">Suma:</label>
                    </div>
                    <div class="mb-3 col-6">
                        <input class="form-control" id="suma" class="form-text" name="suma" value="<%= preke != null ? preke.getSuma() : ""%>">
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-2">
                        <label for="paskirtis_id">Pasirinkti paskirtį:</label> 
                    </div>
                    <div class="mb-3 col-6">
                        <select class="form-select" id="paskirtis_id" name="paskirtis_id">
                            <% for (Paskirtis p : paskirtys) {
                                    if ((preke != null && preke.getPaskirtis().equals(p)) || (paskirtis != null && paskirtis.getId() == p.getId())) {%>
                            <option selected value="<%=p.getId()%>"><%=p.getId()%>. <%=p.getPavadinimas()%></option>
                            <%} else {%>
                            <option value="<%=p.getId()%>">id: <%=p.getId()%> Paskirtis:<%=p.getPavadinimas()%></option>    
                            <%;
                                    }
                                }%>  
                        </select> 
                    </div>
                </div>
                <div class="row">
                    <div class="mb-3 col-2">
                        <input type="submit" class="btn border border-3 border-success text-success btn-width" value="Išsaugoti">    
                    </div>
                    <div class="mb-3 btn border border-3 border-danger btn-width col-2" >
                        <a href="prekes.jsp?<%=link%>" class="link text-danger">Atmesti</a>
                    </div>
                </div>
        </div>
    </body>
</html>

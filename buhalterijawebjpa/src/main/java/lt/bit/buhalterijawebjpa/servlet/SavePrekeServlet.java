/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package lt.bit.buhalterijawebjpa.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lt.bit.buhalterijawebjpa.data.Paskirtis;
import lt.bit.buhalterijawebjpa.data.Preke;
import lt.bit.buhalterijawebjpa.data.Cekis;

/**
 *
 * @author elzbi
 */
@WebServlet(name = "SavePrekeServlet", urlPatterns = {"/savePreke"})
public class SavePrekeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        EntityManager em = (EntityManager) request.getAttribute("em");
        EntityTransaction tx = em.getTransaction();
        tx.begin();
        
        try {
            Cekis c = null;
            String idStr = request.getParameter("id");
            if (idStr == null) {
                Preke p = new Preke();
                Paskirtis pask = null;
                p.setPreke(request.getParameter("preke"));
                String cekisIdStr = request.getParameter("cekis_id");
                try {
                    int cekisId = Integer.parseInt(cekisIdStr);
                    c = em.find(Cekis.class, cekisId);
                    p.setCekis(c);
                } catch (Exception ex) {
                    //ignored
                }
                String paskIdStr = request.getParameter("paskirtis_id");
                try {
                    int paskId = Integer.parseInt(paskIdStr);
                    pask = em.find(Paskirtis.class, paskId);
                    p.setPaskirtis(pask);
                } catch (Exception ex) {
                    //ignored
                }
                BigDecimal suma = new BigDecimal(request.getParameter("suma"));
                p.setSuma(suma);
                em.persist(p);
            } else {
                Preke p = null;
                try {
                    int id = Integer.parseInt(idStr);
                    p = em.find(Preke.class, id);
                } catch (Exception ex) {
                    //ignored
                }
                if (p != null) {                    
                    Paskirtis pask = null;
                    p.setPreke(request.getParameter("preke"));
                    String cekisIdStr = request.getParameter("cekis_id");
                    try {
                        int cekisId = Integer.parseInt(cekisIdStr);
                        c = em.find(Cekis.class, cekisId);
                        p.setCekis(c);
                    } catch (Exception ex) {
                        //ignored
                    }
                    String paskIdStr = request.getParameter("paskirtis_id");
                    try {
                        int paskId = Integer.parseInt(paskIdStr);
                        pask = em.find(Paskirtis.class, paskId);
                        p.setPaskirtis(pask);
                    } catch (Exception ex) {
                        //ignored
                    }
                    BigDecimal suma = new BigDecimal(request.getParameter("suma"));
                    p.setSuma(suma);
                }
            }
            em.flush();
            response.sendRedirect("prekes.jsp"+(c!=null?"?cekis_id="+c.getId():""));
        } finally {
            tx.commit();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

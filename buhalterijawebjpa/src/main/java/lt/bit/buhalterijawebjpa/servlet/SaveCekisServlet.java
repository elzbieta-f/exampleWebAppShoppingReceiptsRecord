/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package lt.bit.buhalterijawebjpa.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lt.bit.buhalterijawebjpa.data.Cekis;

/**
 *
 * @author elzbi
 */
@WebServlet(name = "SaveCekisServlet", urlPatterns = {"/saveCekis"})
public class SaveCekisServlet extends HttpServlet {

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
            String idStr = request.getParameter("id");
            if (idStr == null) {
                Cekis c = new Cekis();
                c.setParduotuve(request.getParameter("parduotuve"));
                String dataStr = request.getParameter("data");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    c.setData(sdf.parse(dataStr));
                } catch (Exception ex) {
                    System.out.println("Bloga data");
                    response.sendRedirect("index.jsp");
                }
                c.setKomentaras(request.getParameter("komentaras"));
                em.persist(c);
            } else {
                Cekis c = null;
                try {
                    int id = Integer.parseInt(idStr);
                    c = em.find(Cekis.class, id);
                } catch (Exception ex) {
                    // ignored
                }
                if (c != null) {
                    c.setParduotuve(request.getParameter("parduotuve"));
                    String dataStr = request.getParameter("data");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        c.setData(sdf.parse(dataStr));
                    } catch (Exception ex) {
                        System.out.println("Bloga data");
                        response.sendRedirect("index.jsp");
                    }
                    c.setKomentaras(request.getParameter("komentaras"));
                }
            }
            em.flush();
            response.sendRedirect("index.jsp");
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

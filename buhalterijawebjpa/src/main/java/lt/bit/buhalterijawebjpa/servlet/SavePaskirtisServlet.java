
package lt.bit.buhalterijawebjpa.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import lt.bit.buhalterijawebjpa.data.Paskirtis;


@WebServlet(name = "SavePaskirtisServlet", urlPatterns = {"/savePaskirtis"})
public class SavePaskirtisServlet extends HttpServlet {

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
                Paskirtis p=new Paskirtis();
                p.setPavadinimas(request.getParameter("pavadinimas"));
                em.persist(p);
            } else {
                Paskirtis p=null;
                try {
                    int id=Integer.parseInt(idStr);
                    p=em.find(Paskirtis.class, id);
                } catch (Exception ex){
                    //ignored
                }
                if (p!=null){
                    p.setPavadinimas(request.getParameter("pavadinimas"));
                }
            }
            em.flush();
            response.sendRedirect("paskirtys.jsp");
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

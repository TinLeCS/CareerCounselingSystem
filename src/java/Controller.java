/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.xml.sax.SAXException;

/**
 *
 * @author Leader
 */
@WebServlet(urlPatterns = {"/Controller"})
public class Controller extends HttpServlet {
    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParserConfigurationException, SAXException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            out.println("<body>");
            HttpSession session = request.getSession();
            String fileName = request.getParameter("name").replace(" ", "_") + "_" + request.getParameter("mail");
            String jspPath = session.getServletContext().getRealPath("/");
            File source = new File(jspPath + "/sample.xml");
            File dest = new File(jspPath + "/" + fileName + ".xml");
            File career = new File(jspPath + "/career.xml");

            InputStream input = new FileInputStream(source);
            OutputStream output = new FileOutputStream(dest);

            byte[] buf = new byte[1024];
            int bytesRead;

            while ((bytesRead = input.read(buf)) > 0) 
                output.write(buf, 0, bytesRead);
            input.close();
            output.close();
            
            Document doc = Jsoup.parse(dest, "UTF-8", "");
            for (int i = 1; i <= 43; i++){
                Elements intersts = doc.select("#interst_" + i);
                intersts.get(0).attr("point",request.getParameter("interst_" + i));
            }
            
            for (int i = 1; i <= 16; i++){
                Elements intersts = doc.select("#ability_" + i);
                intersts.get(0).attr("point", request.getParameter("ability_" + i));
            }
            
            for (int i = 1; i <= 16; i++){
                Elements intersts = doc.select("#subject_" + i);
                intersts.get(0).attr("grade", (request.getParameter("subject_" + i) == null) ? "" : request.getParameter("subject_" + i));
            }
            transferGrade(doc);

            FileWriter fileWriter = new FileWriter(jspPath + "/" + fileName + ".xml");
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            bufferedWriter.write(doc.toString());
            bufferedWriter.close();
            
            double[] distance = {0,0,0,0,0,0};
            int [] n = {0,0,0,0,0,0};
            String[] type = {"r","i","a","s","e","c"};
            

            for (int i = 0; i < type.length; i++) {
                Elements interests = doc.getElementsByTag(type[i] + "_interests");
                Elements skills = doc.getElementsByTag(type[i] + "_skills");
  
                Elements interest = interests.get(0).children();
                for (int j = 0; j < interest.size(); j++) {
                    double point = Double.parseDouble(interest.get(j).attr("point"));
                    distance[i] += (5-point)*(5-point);
                     n[i]++;
                }             
                
                Elements skill = skills.get(0).children();
                for (int j = 0; j < skill.size(); j++) {
                    double point = Double.parseDouble(skill.get(j).attr("point"));
                    distance[i] += (5-point)*(5-point);
                     n[i]++;
                }                               
            }
            
            Elements abilities = doc.getElementsByTag("ability");
            for (int i = 0; i < abilities.size(); i++) {
                Element ability = abilities.get(i);
                double point = Double.parseDouble(ability.attr("point"));
                Elements eff_intersts = ability.getElementsByTag("eff_interst");
                    for (int j = 0; j < eff_intersts.size(); j++){
                        int typeNum = convertType(eff_intersts.get(j).text());                       
                        distance[typeNum] += (5-point)*(5-point);
                        n[typeNum]++;
                    }
             }
            for (int i =0; i < type.length; i++){
                distance[i] = Math.sqrt(distance[i]/n[i]);
                request.setAttribute("type" + i, toPercentage(distance[i]));
//                out.println(toPercentage(distance[i]) + "<br>");
            }
            String[] codeType = findThreeMin(distance);
            request.setAttribute("personality", codeType[0]);
            ArrayList careerList = suggestCareer(createCombination(codeType[0], codeType[1], codeType[2]), career);
            request.setAttribute("career", careerList);
//            for (int i =0; i < careerList.size(); i++){
//                out.println(careerList.get(i).toString() + "<br>");
//            }
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/result.jsp");
            requestDispatcher.forward(request, response);
        }
        

         finally {
//            response.sendRedirect("index.jsp");
        }
    }
        private ArrayList suggestCareer(ArrayList code, File career) throws IOException{
        ArrayList careerList = new ArrayList();

        Document doc = Jsoup.parse(career, "UTF-8", "");
        for (int i = 0; i < code.size(); i++){
            Elements id = doc.select("#" + (String)code.get(i));
            if (!id.isEmpty()){
                Elements careers = id.get(0).children();
                for (int j = 0; j < careers.size(); j++)
                    careerList.add(careers.get(j).text());
            }
        }        
        return careerList;
        
    }
    
    private static String[] findThreeMin(double[] distance){
        String[] type = {"R","I","A","S","E","C"};
        String[] output = new String[3];
        for (int i = 0; i < 3; i++){
            int index = 0;
            double min = distance[0];
            for (int j = 1; j < distance.length; j++)                
                if (distance[j] < min){
                    min = distance[j];
                    index = j;
                }
            distance[index] = 6;
            output[i] = type[index];
        }
        return output;
    }
    
    private double toPercentage(double num){
        num = Math.round((1 - num/5)*10000);         
        return num/100;
    }
    private ArrayList createCombination(String a, String b, String c){
        ArrayList comb = new ArrayList();
        comb.add(a + b + c);
        comb.add(a + c + b);
        comb.add(b + a + c);
        comb.add(b + c + a);
        comb.add(c + a + b);
        comb.add(c + b + a);
        return comb;        
    }
    
    private int convertType(String type){
        if (type.equals("r_interst"))
                return 0;
        else if (type.equals("i_interst"))
                return 1;
        else if (type.equals("a_interst"))
                return 2;
        else if (type.equals("s_interst"))
                return 3;
        else if (type.equals("e_interst"))
                return 4;
        else return 5;
    }
    
    private void transferGrade(Document doc) {
        Elements skills = doc.getElementsByTag("skill");
        Elements eff_skills = doc.getElementsByTag("eff_skill");
        for (int i = 0; i < skills.size(); i++) {
            Element skill = skills.get(i);
            String skill_name = skill.text();

            double influce_level = 0;
            double grade = 0;

            for (int j = 0; j < eff_skills.size(); j++) {
                Element eff_skill = (Element) eff_skills.get(j);
                String eff_skill_name = eff_skill.text();
                if (!(eff_skill.parentNode().attr("grade").equals("")) && eff_skill_name.equals(skill_name)) {
                    double cur_influce_level = Double.parseDouble(eff_skill.attr("influce_level"));
                    double parent_grade = Double.parseDouble(eff_skill.parentNode().attr("grade"));

                    if (cur_influce_level > influce_level ) {
                        influce_level = cur_influce_level;
                        grade = parent_grade;
                    } else if ( cur_influce_level == influce_level) {
                        if (parent_grade > grade) {
                            grade = parent_grade;
                        }
                    }
                }
            }
            if (influce_level != 0) {
                if (grade >= 0 && grade <= 1) {
                    grade = 0;
                }  else if (grade > 1 && grade <= 3.5) {
                    grade = 1;
                } else if (grade > 3.5 && grade <= 5) {
                    grade = 2;
                } else if (grade > 5 && grade <= 6.5) {
                    grade = 3;
                } else if (grade > 6.5 && grade <= 8.5) {
                    grade = 4;
                } else if (grade > 8.5 && grade <= 10) {
                    grade = 5;
                }
                skill.attr("point", Double.toString(grade));
            } else {
                skill.attr("point", "0");
            }
        }
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SAXException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
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

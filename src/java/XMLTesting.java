/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


/**
 *
 * @author Leader
 */
@WebServlet(urlPatterns = {"/XMLTesting"})
public class XMLTesting extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            File dest = new File("E:/University/NetBeansProjects/Thesis Test/build/web/ds_sd@f.gmail.com.xml");
            Document doc = Jsoup.parse(dest, "UTF-8", "");

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
                out.println(toPercentage(distance[i]) + "<br>");
            }
            String[] codeType = findThreeMin(distance);
            ArrayList id = createCombination(codeType[0], codeType[1], codeType[2]);
            ArrayList careerList = suggestCareer(id);

            for (int i =0; i < careerList.size(); i++){
                out.println(careerList.get(i).toString() + "<br>");
            }
            out.println("</body>");

        } finally {            
            out.close();
        }
        
    }
    
    private ArrayList suggestCareer(ArrayList code) throws IOException{
        ArrayList careerList = new ArrayList();
        File dest = new File("E:/University/NetBeansProjects/Thesis Test/build/web/career.xml");
        Document doc = Jsoup.parse(dest, "UTF-8", "");
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
        processRequest(request, response);
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

<%@page import="java.io.File"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Main.css" TYPE="text/css">
        <SCRIPT LANGUAGE="JavaScript">
            var i = 1;
            var j = 1;
            function backInterest(){                
                document.getElementById("interest" + i.toString()).style.visibility = "hidden";
                i--;
                if (i == 0){
                    i = 43;
                }
                document.getElementById("interest" + i.toString()).style.visibility = "visible";
            }
            function nextInterest(){                
                document.getElementById("interest" + i.toString()).style.visibility = "hidden";
                i++;
                if (i == 44){
                    i = 1;
                }
                document.getElementById("interest" + i.toString()).style.visibility = "visible";
            }          
            function backAbility(){                
                document.getElementById("ability" + j.toString()).style.visibility = "hidden";
                j--;
                if (j == 0){
                    j = 18;
                }
                document.getElementById("ability" + j.toString()).style.visibility = "visible";
            }
           function nextAbility(){
                document.getElementById("ability" + j.toString()).style.visibility = "hidden";
                j++;
                if (j == 19){
                    j = 1;
                }
                document.getElementById("ability" + j.toString()).style.visibility = "visible";
            }
        </SCRIPT>
        <title>Vocational Counseling Web Site</title>
    </head>
    <body>
        <form action="Controller" method="post">
            <div align='center'style='position: absolute; top:200px; left:450px'>
            <h3>Please input your profile!</h3><br>
            <table>
                <tr>
                    <td><b>Name: </b></td>
                    <td><input type="text" name="name" required></td>           
                    
                </tr>
                <tr>                   
                    <td><b>Email: </b></td>
                    <td><input type="email" name="mail" required></td>                      

                </tr>
            </table>    
            </div>   
            <div align='center' style='position: absolute; top:350px; left:550px'>
            <h3>Please check your interests!</h3><br>
            </div>
            <div align='center' id='interest1' style='width:850px; max-width:850px;display: inline-block; position: absolute; top:400px; left:250px'>
                <b>How do you feel when doing manual work?</b><br>
                <input type= 'radio' name = 'interst_1' value = '1' required> Dislike
                <input type= 'radio' name = 'interst_1' value = '2' required> A little
                <input type= 'radio' name = 'interst_1' value = '3' required> Neutral
                <input type= 'radio' name = 'interst_1' value = '4' required> Like
                <input type= 'radio' name = 'interst_1' value = '5' required> Strongly Like
            </div>       
            <%
                String jspPath = session.getServletContext().getRealPath("/");
                String txtFilePath = jspPath+ "/questionnaire.txt";
                BufferedReader reader = new BufferedReader(new FileReader(txtFilePath));
                StringBuilder sb = new StringBuilder();
                String interest;
                int i = 2;
                while((interest = reader.readLine())!= null){
                    sb.append("<div align='center' id='interest" + i +"' style='width:850px; max-width:850px;display: inline-block; position: absolute; top:400px; left:250px; visibility: hidden'>");
                    sb.append("<b>" + interest + "</b><br>");
                    sb.append("<input type= 'radio' name = 'interst_" + i + "' value = '1' required> Dislike");
                    sb.append("<input type= 'radio' name = 'interst_" + i + "' value = '2' required> A little");
                    sb.append("<input type= 'radio' name = 'interst_" + i + "' value = '3' required> Neutral");
                    sb.append("<input type= 'radio' name = 'interst_" + i + "' value = '4' required> Like");
                    sb.append("<input type= 'radio' name = 'interst_" + i + "' value = '5' required> Strongly Like<br>");
                    sb.append("</div>");
                    i++;
                }
                out.println(sb.toString());                
            %>
            <div align="center" style="position: absolute; top:450px; left:550px">
                <img src="Images/Back.png" title="Back" style="cursor:pointer" onclick="backInterest()">
            </div>
            <div align="center" style="position: absolute; top:450px; left:700px">
                <img src="Images/Next.png" title="Next" style="cursor:pointer" onclick="nextInterest()">
            </div>
             <div align='center' style='position: absolute; top:575px; left:450px'>
            <h3>Please tell your competence for each activity!</h3><br>
            </div>
            <div align='center' id='ability1' style='position: absolute; top:625px; left:450px'>
                <b>Teaching others</b><br>
                <input type= 'radio' name = 'ability_1' value = '1' required> Unable to do
                <input type= 'radio' name = 'ability_1' value = '2' required> Not good
                <input type= 'radio' name = 'ability_1' value = '3' required> Neutral
                <input type= 'radio' name = 'ability_1' value = '4' required> Good
                <input type= 'radio' name = 'ability_1' value = '5' required> Very competent
            </div>       
            <%
                
                txtFilePath = jspPath+ "/abilities.txt";
                reader = new BufferedReader(new FileReader(txtFilePath));
                sb = new StringBuilder();
                String ability;
                i = 2;
                while((ability = reader.readLine())!= null){
                    sb.append("<div align='center' id='ability" + i +"' style='position: absolute; top:625px; left:450px; visibility: hidden'>");
                    sb.append("<b>" + ability + "</b><br>");
                    sb.append("<input type= 'radio' name = 'ability_" + i + "' value = '1' required> Unable to do");
                    sb.append("<input type= 'radio' name = 'ability_" + i + "' value = '2' required> Not good");
                    sb.append("<input type= 'radio' name = 'ability_" + i + "' value = '3' required> Neutral");
                    sb.append("<input type= 'radio' name = 'ability_" + i + "' value = '4' required> Good");
                    sb.append("<input type= 'radio' name = 'ability_" + i + "' value = '5' required> Very competent<br>");
                    sb.append("</div>");                    
                    i++;
                }
                out.println(sb.toString());                
            %>
            <div align="center" style="position: absolute; top:675px; left:550px">
                <img src="Images/Back.png" title="Back" style="cursor:pointer" onclick="backAbility()">
            </div>
            <div align="center" style="position: absolute; top:675px; left:700px">
                <img src="Images/Next.png" title="Next" style="cursor:pointer" onclick="nextAbility()">
            </div>
            <div align="center" style="position: absolute; top:775px; left:400px">
                <h3>Please input your grades for each subject in grade 12!</h3><br>
            </div>
            <div align="center" style="position: absolute; top:825px; left:400px">
                <table align="center">
                    <tr>
                        <td><b>Mathematics</b></td>
                        <td><input type= 'number' name = 'subject_1' min = '0' max = '10' step = '0.1' value = 0 required></td>
                        <td><b>English</b></td>
                        <td><input type= 'number' name = 'subject_2' min = '0' max = '10' step = '0.1' value = 0 required></td>
                    </tr>
                    <tr>
                        <td><b>Literature</b></td>
                        <td><input type= 'number' name = 'subject_3' min = '0' max = '10' step = '0.1' value = 0 required></td>
                        <td><b>Chemistry</b></td>
                        <td><input type= 'number' name = 'subject_4' min = '0' max = '10' step = '0.1' value = 0 required></td>
                    </tr>
                    <tr>
                        <td><b>Physics</b></td>
                        <td><input type= 'number' name = 'subject_5' min = '0' max = '10' step = '0.1' value = 0 required></td>
                        <td><b>Biology</b></td>
                        <td><input type= 'number' name = 'subject_6' min = '0' max = '10' step = '0.1' value = 0 required></td>
                    </tr>
                    <tr>
                        <td><b>History</b></td>
                        <td><input type= 'number' name = 'subject_7' min = '0' max = '10' step = '0.1' value = 0 required></td>
                        <td><b>Informatics</b></td>
                        <td><input type= 'number' name = 'subject_8' min = '0' max = '10' step = '0.1' value = 0 required></td>
                    </tr>
                    <tr>
                        <td><b>Civic Education</b></td>
                        <td><input type= 'number' name = 'subject_9' min = '0' max = '10' step = '0.1' value = 0 required></td>
                        <td><b>Physical Education</b></td>
                        <td><input type= 'number' name = 'subject_10' min = '0' max = '10' step = '0.1' value = 0 required></td>
                    </tr>      
                    <tr>
                        <td><b>Geography</b></td>
                        <td><input type= 'number' name = 'subject_11' min = '0' max = '10' step = '0.1' value = 0 required></td>
                        <td><b>Technology</b></td>
                        <td><input type= 'number' name = 'subject_12' min = '0' max = '10' step = '0.1' value = 0 required></td>
                    </tr>
                    <tr>
                        <td colspan="3"><b>Young Union Activities</b></td>
                        <td>
                            <select name="subject_16">
                                <option value="2">No, just study</option>
                                <option value="4">Join in class level</option>
                                <option value="6">Join in school level </option>
                                <option value="8">Usually join</option>
                                <option value="9">Very active</option>                                           
                            </select>
                        </td>
                    </tr>
                    <tr>                        
                        <td colspan="3">
                            <i>Please input only one of three subject</i><br>
                            <b>Electricity</b><br>
                            <b>Photograph</b><br>
                            <b>Forestry</b><br>
                        </td>
                        <td><br>
                            <input type= 'number' name = 'subject_13' min = '0' max = '10' step = '0.1' value = 0 required><br>
                            <input type= 'number' name = 'subject_14' min = '0' max = '10' step = '0.1' value = 0 required><br>
                            <input type= 'number' name = 'subject_15' min = '0' max = '10' step = '0.1' value = 0 required><br>
                        </td>
                    </tr>     
                </table>
            </div>
            <div align="center" style="position: absolute; top:1125px; left:600px">
                <button type="submit" id="submit"></button>
            </div>
        </form>
    </body>
</html>
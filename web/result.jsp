<%-- 
    Document   : result
    Created on : Mar 11, 2014, 5:31:32 PM
    Author     : Leader
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Result.css" TYPE="text/css">
        <title>Vocational Suggestion</title>
    </head>
    <body>
        <%
            double type0 = (Double)request.getAttribute("type0");
            double type1 = (Double)request.getAttribute("type1");
            double type2 = (Double)request.getAttribute("type2");
            double type3 = (Double)request.getAttribute("type3");
            double type4 = (Double)request.getAttribute("type4");
            double type5 = (Double)request.getAttribute("type5");
        %>
        <br><br>
        <table align="center" width="500">
            <tr>
                <td>Realistic</td>
                <td align="center"><meter max=100 value=<%=type0%> high=50></meter>
                </td>
                <td><%=type0%>%</td>
            </tr>
            <tr>
                <td>Investigative</td>
                <td align="center"><meter max=100 value=<%=type1%> high=50></meter>
                </td>
                <td><%=type1%>%</td>
            </tr>
            <tr>
                <td>Artistic</td>
                <td align="center"><meter max=100 value=<%=type2%> high=50></meter>
                </td>
                <td><%=type2%>%</td>
            </tr>
            <tr>
                <td>Social</td>
                <td align="center"><meter max=100 value=<%=type3%> high=50></meter>
                </td>
                <td><%=type3%>%</td>
            </tr>
            <tr>
                <td>Enterprising</td>
                <td align="center"><meter max=100 value=<%=type4%> high=50></meter>
                </td>
                <td><%=type4%>%</td>
            </tr>
            <tr>
                <td>Conventional</td>
                <td align="center"><meter max=100 value=<%=type5%> high=50></meter>
                </td>
                <td><%=type5%>%</td>
            </tr>
        </table>
            <br><br><br>
            <%
                String type = (String)request.getAttribute("personality");
                if (type.equals("R")) {
                        %>
                        <div style="margin-left: 250px; margin-right: 250px;"><img src="Images/Realistic.png" style="float: left; padding: 6px 10px 6px 0px;"><h2>You&#039;re a Doer</h2><p>Your primary interest area is Realistic, which means you are a <b>doer</b> who enjoys working with practical, hands-on problems and solutions. Doers enjoy building, fixing, and operating machinery, and&nbsp;often like working outdoors. Doers like working with their hands and bodies. They are often athletic.</p>
                            <p>Doers often prefer jobs where they do not have to work with other people too much of the time. They also usually like to avoid jobs that involve a lot of paperwork or abstract problem-solving.</p>
                            <p>Doers like their work best when they can see a real, physical result of their efforts. As a Doer, your primary career goal will be to discover a job where you can use your physical or mechanical skills to take practical, observable action on the world around you.</p>
                        <%                    }
                            if (type.equals("I")) {
                        %>
                        <div style="margin-left: 250px; margin-right: 250px;"><img src="Images/Investigative.png" style="float: left; padding: 6px 10px 6px 0px;"><h2>You're a Thinker</h2><p>Your primary interest area is Investigative, which means you are a <b>thinker</b> who enjoys working with ideas, theories, and logical analysis. Thinkers enjoy abstract problem-solving and often like to be in a scientific or academic environment. Thinkers want to discover new ideas in their work, and enjoy doing research.</p>
                            <p>Thinkers prefer jobs that are more intellectual than physical. They often like to work independently, and would usually rather spend their time analyzing data and concepts than trying to motivate or lead other people. </p>
                            <p>Thinkers like their work best when they can explore concepts and create theories about the way things work. As a Thinker, your primary career goal will be to find a job where you can think through complex, abstract problems, and examine data to discover patterns and principles.</p>
                        <%                     }
                           if (type.equals("A")) {
                        %>   
                        <div style="margin-left: 250px; margin-right: 250px;"><img src="Images/Artistic.png" style="float: left; padding: 6px 10px 6px 0px;"><h2>You're a Creator</h2><p>Your primary interest area is Artistic, which means you are a <b>creator</b> interested in imagination, self-expression, and artistic experience. Creators enjoy drama, fine arts, music, and creative writing. They like to work with visual elements such as forms, colors, and patterns.</p>
                            <p>Creators like an unstructured work environment where they can be free to express their individuality. They usually like to avoid work settings with a lot of strict rules or standard procedures that must be followed.</p>
                            <p>Creators like their work best when they can think outside the box and put their own personal spin on what they do. As a Creator, your primary career goal will be to find a job where you can use your imagination and solve creative problems in a unique and original way.</p>
                        <%                    }
                            if (type.equals("S")) {
                        %>
                        <div style="margin-left: 250px; margin-right: 250px;"><img src="Images/Social.png" style="float: left; padding: 6px 10px 6px 0px;"><h2>You're a Helper</h2><p>Your primary interest area is Social, which means you are a <b>helper</b> interested in improving the lives of other people through your work. Helpers want to be of service to others, and like to help them learn and develop. They enjoy teaching, counseling, and assisting people in need.</p>
                            <p>Helpers like a people-oriented work environment where they can interact with and serve others. They often enjoy working with children or the elderly. Helpers typically prefer to avoid jobs that require too much time working with machines or data.</p>
                            <p>Helpers like their work best when they can make a positive impact on people's lives. As a Helper, your primary career goal will be to find a job that is consistent with your values, where you can feel that you are making a difference in the lives of other people. </p>
                        <%                    }
                            if (type.equals("E")){
                        %>
                        <div style="margin-left: 250px; margin-right: 250px;"><img src="Images/Enterprising.png" style="float: left; padding: 6px 10px 6px 0px;"><h2>You're a Persuader</h2><p>Your primary interest area is Enterprising, which means you are a <b>persuader</b> who is interested in managing, leading, and motivating other people. Persuaders typically like to influence others, whether selling them a product or inspiring them to do their best work. They often seek out leadership roles.</p>
                            <p>Persuaders often enjoy a business environment where they can start up and manage projects. They are excited by risk and typically prefer to avoid roles where they are not enabled to take decisive action. </p>
                            <p>Persuaders like their work best when they can be influential and make important decisions. As a Persuader, your primary career goal will be to find a job where you can take the initiative to start and carry out new ventures, and where you can influence others to contribute to your goals.</p>
                        <%                    }
                            if (type.equals("C")) {
                        %>
                        <div style="margin-left: 250px; margin-right: 250px;"><img src="Images/Conventional.png" style="float: left; padding: 6px 10px 6px 0px;"><h2>You're an Organizer</h2><p>Your primary interest area is Conventional, which means you are an <b>organizer</b> who enjoys handling data, details, and processes. Organizers like structured work environments where they can follow clear procedures to organize information. They often enjoy office work, especially managing systems, records, and files.</p>
                            <p>Organizers like to have a routine for their work and want precise standards for what they do. They typically do best to avoid jobs where the rules and expectations are unclear, or where there is not a clear process to follow. </p>
                            <p>Organizers like their work best when they can use a systematic process to finish tasks correctly and consistently. As an Organizer, your primary career goal will be to find a job where you can handle data and details with precision, and follow standardized procedures to organize and manage information.</p>                        
                        <%
                            }
                        %>
                        <p>
                            Base on interaction amongst three types of interest, your most suitable careers in decreasing order are: <b>
                            <%
                                ArrayList careerList = (ArrayList) request.getAttribute("career");
                                for (int i = 0; i < careerList.size(); i++){
                                    out.println(careerList.get(i) + ","); 
                                    if (i == careerList.size() - 1)
                                      out.println(careerList.get(i) + ".");  
                                }
                            %>
                            </b>
                        </p>
                        </div>
    </body>
</html>

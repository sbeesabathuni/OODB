/****************************************************************************
CSE532 -- Project 2
File name: ObjectOrientedDBDesign.sql
Author(s): Sravya Beesabathuni (111327265)
Pooja R Dalaya (111323959 )
Brief description: This file contains the connection to database through JDBC, gets the request from jsp file and displays the result based on the parameter passed. 
****************************************************************************/

/*We pledge our honor that all parts
of this project were done by us alone and without collaboration with
anybody else.*/


import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.sql.*;

// Extend HttpServlet class

@WebServlet("/login")
public class WOCO extends HttpServlet {
 
   private String message;

   public void init() throws ServletException {
      // Do required initialization
      message = "Hello World";
   }

   public void doGet(HttpServletRequest request, HttpServletResponse response)
		      throws ServletException, IOException {
		   
		      // JDBC driver name and database URL
		      //final String JDBC_DRIVER = "org.postgresql.Driver";  
		      final String DB_URL="jdbc:postgresql://localhost:5432/woco";

		      //  Database credentials
		      final String USER = "postgres";
		      final String PASS = "password";

		      // Set response content type
		      response.setContentType("text/html");
		      PrintWriter out = response.getWriter();
		      String title = "Database Result";
		      
		      String docType =
		         "<!doctype html public \"-//w3c//dtd html 4.0 " + "transitional//en\">\n";
		      
		      out.println(docType +
		         "<html>\n" +
		         "<head><title>" + title + "</title></head>\n" +
		         "<body bgcolor = \"#f0f0f0\">\n" +
		         "<h1 align = \"center\">" + title + "</h1>\n");
		      try {
		         // Register JDBC driver
		         Class.forName("org.postgresql.Driver");

		         // Open a connection
		         Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

		         // Execute SQL query
		         Statement stmt = conn.createStatement();
		         String sql;
		         String queryNumber= request.getParameter("param");
		         System.out.println(queryNumber);
		         ResultSet rs = null;
		         switch(queryNumber) {
		         case "1":  
		        	 	sql = "select distinct(c.name) as cname from person p, company c, unnest(p.company_owned_list) as personowns, unnest(c.board_members) as bm where bm=p.id and c.id=personowns.id and personowns.shares_owned>0 order by c.name;";
			         rs = stmt.executeQuery(sql);

			         // Extract data from result set
			         while(rs.next()){
			            String name = rs.getString("cname");
			            out.println(" Company= " + name + "<br>");
			         }
			         break;
		         case "2":  
		        	 	sql = "select p.name, sum(complist.shares_owned*c.share_price) as networth from person p, company c, unnest(p.company_owned_list) as complist where complist.id = c.id and  complist.shares_owned >0 group by p.name order by p.name;";
			         rs = stmt.executeQuery(sql);

			         // Extract data from result set
			         while(rs.next()){
			            String name = rs.getString("name");
			            String networth = rs.getString("networth");
			            out.println(" Person= " + name + "<br>");
			            out.println(" Networth= " + networth + "<br>");
			            out.println("<br>");
			         }
			         break;
		         case "3":  
		        	 	sql = "select c.name as companyName, p.name as personName from company c, person p, unnest(c.board_members) as bm, unnest(p.company_owned_list) as complist where p.id = bm and complist.id = c.id and complist.shares_owned in (select max(complist.shares_owned) from person p, company c, unnest(p.company_owned_list) as complist , unnest(c.board_members) as bm where bm=p.id and complist.id = c.id and complist.shares_owned>0 group by c.id)  order by c.name;";
			         rs = stmt.executeQuery(sql);

			         // Extract data from result set
			         while(rs.next()){
			            String cname = rs.getString("companyName");
			            String pname = rs.getString("personName");
			            out.println(" Company= " + cname + "<br>");
			            out.println(" Person= " + pname + "<br>");
			            out.println("<br>");
			         }
			         break;
		         case "4":  
		        	 	sql = "select c1.name as c1name,c2.name as c2name from company c1, company c2 where c1.industry && c2.industry and c1.id<>c2.id and not exists(select c.id from unnest(c2.board_members) as bm2, company c, person p, unnest(p.company_owned_list) as colist2 where colist2.id=c.id and p.id=bm2 except select co.id from company co,unnest(c1.board_members) as b1,unnest(c2.board_members) as b2, person p1,person p2, unnest(p1.company_owned_list) as co1,unnest(p2.company_owned_list) as co2 where p1.id=b1 and p2.id=b2 and co.id=co1.id and co.id=co2.id group by co.id,co1.shares_owned having co1.shares_owned>=max(co2.shares_owned));";
			         rs = stmt.executeQuery(sql);

			         // Extract data from result set
			         while(rs.next()){
			            String c1 = rs.getString("c1name");
			            String c2 = rs.getString("c2name");
			            out.println(" Company1= " + c1 + "<br>");
			            out.println(" Company2= " + c2 + "<br>");
			            out.println("<br>");
			            
			         }
			         break;
		         case "5":  
		        	 	sql = "WITH RECURSIVE PERSON_INDIRECTLY_OWNS AS (\n" + 
		        	 			"SELECT P.ID AS PERSONID, COMPLIST.ID as COMPANYID, trunc((complist.shares_owned/c.shares_issued),4) as val FROM COMPANY C, PERSON P, UNNEST(P.COMPANY_OWNED_LIST) AS COMPLIST WHERE complist.id = c.id and complist.shares_owned > 0\n" + 
		        	 			"UNION \n" + 
		        	 			"Select po.personid as PERSONID, co.COMPANY2 as COMPANYID, round((po.val*co.val),5) as val  from PERSON_INDIRECTLY_OWNS po, COMPANY_INDIRECTLY_OWNS co where po.COMPANYID = co.COMPANY1 and co.val > 0\n" + 
		        	 			"),\n" + 
		        	 			"COMPANY_INDIRECTLY_OWNS AS (\n" + 
		        	 			"SELECT C.ID AS COMPANY1, CLIST.ID AS COMPANY2, trunc((CLIST.shares_owned/c2.shares_issued), 4) as val FROM COMPANY C, COMPANY C2, UNNEST(C.COMPANY_OWNED_LIST)CLIST WHERE C2.ID = CLIST.ID AND CLIST.SHARES_OWNED > 0\n" + 
		        	 			"UNION\n" + 
		        	 			"SELECT C.ID AS COMPANY1, CO.COMPANY2 AS COMPANY2, trunc((co.val *(CLIST.SHARES_OWNED/C2.SHARES_ISSUED)),4) AS VAL FROM COMPANY C, COMPANY_INDIRECTLY_OWNS CO, COMPANY C2, UNNEST(C.COMPANY_OWNED_LIST) CLIST WHERE CO.COMPANY1 = CLIST.ID AND CLIST.ID = C2.ID AND CLIST.SHARES_OWNED > 0 AND CO.VAL > 0\n" + 
		        	 			")\n" + 
		        	 			"SELECT per.name as pname, c.name as cname, SUM(p.val*100) as percentage  FROM PERSON_INDIRECTLY_OWNS P, person per, company c where per.id = p.personId and c.id = p.companyId group by per.name, c.name having SUM(p.val*100) > 10 order by per.name;";
			         rs = stmt.executeQuery(sql);

			         // Extract data from result set
			         while(rs.next()){
			        	 		String cname = rs.getString("cname");
				            String pname = rs.getString("pname");
				            String per = rs.getString("percentage");
				            out.println(" Person= " + pname + "<br>");
				            out.println(" Company= " + cname + "<br>");
				            out.println(" Percentage= " + per + "<br>");
				            out.println("<br>");
			         }
			         break;    
		         }
		         out.println("<a href=\"#\" onclick=\"history.go(-1)\">Go Back</a>");
		         out.println("</body></html>");
		         // Clean-up environment
		         rs.close();
		         stmt.close();
		         conn.close();
		      } catch(SQLException se) {
		         //Handle errors for JDBC
		         se.printStackTrace();
		      } catch(Exception e) {
		         //Handle errors for Class.forName
		         e.printStackTrace();
		      } //end try
		   }

   public void destroy() {
      // do nothing.
   }
}
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>

<%
    // Debugging: Print received parameters
    System.out.println("Received Name: " + request.getParameter("name"));
    System.out.println("Received Role: " + request.getParameter("role"));

    String name = request.getParameter("name");
    String role = request.getParameter("role");
    String specialization = request.getParameter("specialization");
    String location = request.getParameter("location");
    String contact = request.getParameter("contact");
    String availability = request.getParameter("availability");

    if (name == null || role == null) {
        System.out.println("Missing required fields!");
        response.sendRedirect("error.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement pst = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/codeurja", "root", "krrish@001#400");

        String sql = "INSERT INTO medical_staff (name, role, specialization, location, contact, availability) VALUES (?, ?, ?, ?, ?, ?)";
        pst = con.prepareStatement(sql);
        pst.setString(1, name);
        pst.setString(2, role);
        pst.setString(3, specialization);
        pst.setString(4, location);
        pst.setString(5, contact);
        pst.setString(6, availability);

        int rows = pst.executeUpdate();
        
        if (rows > 0) {
            System.out.println("Data inserted successfully!");
            response.sendRedirect("responder.jsp");
        } else {
            System.out.println("Data insertion failed!");
            response.sendRedirect("minister_dashboard.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("minister_dashboard.jsp");
    } finally {
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>

<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FumettoVerse - Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .prodotto {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
<h1>Benvenuto su FumettoVerse</h1>
<h2>Ultimi Fumetti disponibili:</h2>

<%
    // Parametri di connessione al database
    String dbURL = "jdbc:mysql://localhost:3306/fumettoverse";
    String dbUser = "root"; // sostituisci con il tuo utente
    String dbPass = "DavideSQL05";     // sostituisci con la tua password

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        stmt = conn.createStatement();
        String sql = "SELECT titolo, prezzo, disponibilita FROM prodotto ORDER BY data_pubblicazione DESC LIMIT 10";
        rs = stmt.executeQuery(sql);

        while (rs.next()) {
%>
            <div class="prodotto">
                <h3><%= rs.getString("titolo") %></h3>
                <p>Prezzo: €<%= rs.getBigDecimal("prezzo") %></p>
                <p>Disponibilità: <%= rs.getInt("disponibilita") %> copie</p>
            </div>
<%
        }
    } catch (Exception e) {
        out.println("<p>Errore: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>

</body>
</html>

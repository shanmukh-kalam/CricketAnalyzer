
package com.cricket.analyzer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
        "jdbc:mysql://localhost:3306/cricket_analyzer";
    private static final String USER = "root";
    private static final String PASSWORD = "hardikpandya2008";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                "MySQL driver not found. Add Connector/J to WEB-INF/lib.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

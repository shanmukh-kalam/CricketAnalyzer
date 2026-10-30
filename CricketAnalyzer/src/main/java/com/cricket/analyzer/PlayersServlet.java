
package com.cricket.analyzer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/players")
public class PlayersServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Player> players = new ArrayList<>();
        String search = request.getParameter("search");

        String sql = "SELECT * FROM players " +
                "WHERE player_name LIKE ? OR country LIKE ? " +
                "ORDER BY player_name, format_name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String term = "%" + (search == null ? "" : search.trim()) + "%";
            ps.setString(1, term);
            ps.setString(2, term);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Player p = new Player();

                    p.setName(rs.getString("player_name"));
                    p.setCountry(rs.getString("country"));
                    p.setRole(rs.getString("role"));
                    p.setFormat(rs.getString("format_name"));
                    p.setMatches(rs.getInt("matches_played"));
                    p.setRuns(rs.getInt("runs"));
                    p.setHighest(rs.getString("highest_score"));
                    p.setAverage(rs.getDouble("average_runs"));
                    p.setStrikeRate(rs.getDouble("strike_rate"));
                    p.setCenturies(rs.getInt("centuries"));
                    p.setHalfCenturies(rs.getInt("half_centuries"));

                    players.add(p);
                }
            }

        } catch (SQLException e) {
            throw new ServletException("Database connection failed", e);
        }

        request.setAttribute("players", players);
        request.setAttribute("search", search == null ? "" : search);

        request.getRequestDispatcher("/players.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String sql = "INSERT INTO players " +
                "(player_name, country, role, format_name, matches_played, " +
                "runs, highest_score, average_runs, strike_rate, centuries, " +
                "half_centuries) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, request.getParameter("player_name").trim());
            ps.setString(2, request.getParameter("country").trim());
            ps.setString(3, request.getParameter("role"));
            ps.setString(4, request.getParameter("format_name"));
            ps.setInt(5, Integer.parseInt(request.getParameter("matches_played")));
            ps.setInt(6, Integer.parseInt(request.getParameter("runs")));
            ps.setString(7, request.getParameter("highest_score").trim());
            ps.setDouble(8, Double.parseDouble(request.getParameter("average_runs")));
            ps.setDouble(9, Double.parseDouble(request.getParameter("strike_rate")));
            ps.setInt(10, Integer.parseInt(request.getParameter("centuries")));
            ps.setInt(11, Integer.parseInt(request.getParameter("half_centuries")));

            ps.executeUpdate();

            response.sendRedirect(request.getContextPath() + "/players");

        } catch (SQLException | NumberFormatException |
                 NullPointerException e) {
            throw new ServletException(
                    "Could not save player. Check the fields and database.", e);
        }
    }
}


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cricket.analyzer.Player" %>

<%
    List<Player> players =
        (List<Player>) request.getAttribute("players");

    String search = (String) request.getAttribute("search");

    if (search == null) {
        search = "";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Cricket Player Statistics Analyzer</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f6fa;
            color: #263238;
        }

        header {
            background: #123c32;
            color: white;
            padding: 25px 20px;
            text-align: center;
        }

        header h1 {
            margin: 0 0 10px;
        }

        header p {
            margin: 0;
            color: #d7eee5;
        }

        .container {
            width: 94%;
            max-width: 1250px;
            margin: 30px auto;
        }

        .card {
            background: white;
            padding: 24px;
            margin-bottom: 24px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.06);
        }

        h2 {
            margin-top: 0;
            color: #123c32;
        }

        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        input, select, button {
            font: inherit;
            padding: 11px;
            border-radius: 6px;
        }

        input, select {
            border: 1px solid #cbd5d1;
            width: 100%;
            background: white;
        }

        button {
            border: none;
            background: #176b50;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background: #10533e;
        }

        .search-form input {
            flex: 1;
        }

        .table-wrap {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            white-space: nowrap;
        }

        th, td {
            padding: 13px 12px;
            border-bottom: 1px solid #e5eae7;
            text-align: left;
        }

        th {
            background: #e8f2ed;
            color: #123c32;
        }

        tbody tr:hover {
            background: #f7faf8;
        }

        .player-image {
            width: 45px;
            height: 45px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #d7eee5;
            vertical-align: middle;
            display: block;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 16px;
        }

        .field label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            font-size: 14px;
        }

        .submit-row {
            margin-top: 20px;
        }

        .empty {
            text-align: center;
            padding: 25px;
            color: #687872;
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #687872;
        }

        @media (max-width: 700px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .search-form {
                flex-direction: column;
            }

            .card {
                padding: 16px;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>Cricket Player Statistics Analyzer</h1>
    <p>Explore player performance across cricket formats</p>
</header>

<div class="container">

    <section class="card">
        <h2>Search Players</h2>

        <form class="search-form"
              action="<%= request.getContextPath() %>/players"
              method="get">

            <input
                type="text"
                name="search"
                placeholder="Search by player name or country"
                value="<%= search.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>">

            <button type="submit">Search</button>

            <button type="button"
                    onclick="window.location.href='<%= request.getContextPath() %>/players'">
                Reset
            </button>
        </form>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Photo</th>
                        <th>Player</th>
                        <th>Country</th>
                        <th>Role</th>
                        <th>Format</th>
                        <th>Matches</th>
                        <th>Runs</th>
                        <th>Highest Score</th>
                        <th>Average</th>
                        <th>Strike Rate</th>
                        <th>100s</th>
                        <th>50s</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    if (players != null && !players.isEmpty()) {
                        for (Player p : players) {
                %>
                    <tr>
                        <td>
                            <% if ("Virat Kohli".equalsIgnoreCase(p.getName())) { %>
                                <img
                                    src="<%= request.getContextPath() %>/images/virat-kohli.jpeg"
                                    alt="Virat Kohli"
                                    class="player-image">
                            <% } %>
                        </td>

                        <td><%= p.getName() %></td>
                        <td><%= p.getCountry() %></td>
                        <td><%= p.getRole() %></td>
                        <td><%= p.getFormat() %></td>
                        <td><%= p.getMatches() %></td>
                        <td><%= p.getRuns() %></td>
                        <td><%= p.getHighest() %></td>
                        <td><%= String.format("%.2f", p.getAverage()) %></td>
                        <td><%= String.format("%.2f", p.getStrikeRate()) %></td>
                        <td><%= p.getCenturies() %></td>
                        <td><%= p.getHalfCenturies() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="12" class="empty">
                            No players found. Add a player using the form below.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>

    <section class="card">
        <h2>Add Player Statistics</h2>

        <form action="<%= request.getContextPath() %>/players"
              method="post">

            <div class="form-grid">

                <div class="field">
                    <label for="player_name">Player Name</label>
                    <input id="player_name" name="player_name"
                           type="text" required>
                </div>

                <div class="field">
                    <label for="country">Country</label>
                    <input id="country" name="country"
                           type="text" required>
                </div>

                <div class="field">
                    <label for="role">Role</label>
                    <select id="role" name="role" required>
                        <option value="Batter">Batter</option>
                        <option value="Bowler">Bowler</option>
                        <option value="All-rounder">All-rounder</option>
                        <option value="Wicketkeeper">Wicketkeeper</option>
                    </select>
                </div>

                <div class="field">
                    <label for="format_name">Format</label>
                    <select id="format_name" name="format_name" required>
                        <option value="Test">Test</option>
                        <option value="ODI">ODI</option>
                        <option value="T20I">T20I</option>
                        <option value="IPL">IPL</option>
                    </select>
                </div>

                <div class="field">
                    <label for="matches_played">Matches Played</label>
                    <input id="matches_played" name="matches_played"
                           type="number" min="0" required>
                </div>

                <div class="field">
                    <label for="runs">Runs</label>
                    <input id="runs" name="runs"
                           type="number" min="0" required>
                </div>

                <div class="field">
                    <label for="highest_score">Highest Score</label>
                    <input id="highest_score" name="highest_score"
                           type="text" placeholder="e.g. 183 or 150*"
                           required>
                </div>

                <div class="field">
                    <label for="average_runs">Batting Average</label>
                    <input id="average_runs" name="average_runs"
                           type="number" min="0" step="0.01" required>
                </div>

                <div class="field">
                    <label for="strike_rate">Strike Rate</label>
                    <input id="strike_rate" name="strike_rate"
                           type="number" min="0" step="0.01" required>
                </div>

                <div class="field">
                    <label for="centuries">Centuries</label>
                    <input id="centuries" name="centuries"
                           type="number" min="0" required>
                </div>

                <div class="field">
                    <label for="half_centuries">Half-Centuries</label>
                    <input id="half_centuries" name="half_centuries"
                           type="number" min="0" required>
                </div>

            </div>

            <div class="submit-row">
                <button type="submit">Save Player</button>
            </div>
        </form>
    </section>

</div>

<footer>
    Cricket Player Statistics Analyzer
</footer>

</body>
</html>

package com.cricket.analyzer;

public class Player {
    private String name, country, role, format, highest;
    private int matches, runs, centuries, halfCenturies;
    private double average, strikeRate;

    public String getName() { return name; }
    public void setName(String v) { name = v; }

    public String getCountry() { return country; }
    public void setCountry(String v) { country = v; }

    public String getRole() { return role; }
    public void setRole(String v) { role = v; }

    public String getFormat() { return format; }
    public void setFormat(String v) { format = v; }

    public String getHighest() { return highest; }
    public void setHighest(String v) { highest = v; }

    public int getMatches() { return matches; }
    public void setMatches(int v) { matches = v; }

    public int getRuns() { return runs; }
    public void setRuns(int v) { runs = v; }

    public int getCenturies() { return centuries; }
    public void setCenturies(int v) { centuries = v; }

    public int getHalfCenturies() { return halfCenturies; }
    public void setHalfCenturies(int v) { halfCenturies = v; }

    public double getAverage() { return average; }
    public void setAverage(double v) { average = v; }

    public double getStrikeRate() { return strikeRate; }
    public void setStrikeRate(double v) { strikeRate = v; }
}

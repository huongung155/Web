/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Duy Le
 */
public class WatchLog extends Log{
    private int movieID;
    private int memberID;

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public WatchLog(int movieID, int memberID, int logID, String time) {
        super(logID, time);
        this.movieID = movieID;
        this.memberID = memberID;
    }

    

    public int getMovieID() {
        return movieID;
    }

    public void setMovieID(int movieID) {
        this.movieID = movieID;
    }
    
}

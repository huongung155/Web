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
public class AdminLog extends Log{
    private String actionTaken;
    private int memberID;

    public AdminLog(String actionTaken, int memberID, int logID, String time) {
        super(logID, time);
        this.actionTaken = actionTaken;
        this.memberID = memberID;
    }

    

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }
    
    
    public String getActionTaken() {
        return actionTaken;
    }

    public void setActionTaken(String actionTaken) {
        this.actionTaken = actionTaken;
    }
    
}

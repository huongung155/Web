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
public class Member {
    private int memberID;
    private String userName;
    private String password;
    private String email;
    private String profilePictureLink;

    public Member() {
    }

    public Member(int memberID, String userName, String password, String email, String profilePictureLink) {
        this.memberID = memberID;
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.profilePictureLink = profilePictureLink;
    }

    
    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProfilePictureLink() {
        return profilePictureLink;
    }

    public void setProfilePictureLink(String profilePictureLink) {
        this.profilePictureLink = profilePictureLink;
    }
    
}

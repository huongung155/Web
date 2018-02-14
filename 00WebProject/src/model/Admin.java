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
public class Admin extends Member{

    public Admin() {
    }

    public Admin(int memberID, String userName, String password, String email, String profilePictureLink) {
        super(memberID, userName, password, email, profilePictureLink);
    }
    
    public Admin(Member member){
        super(member.getMemberID(), member.getUserName(), member.getPassword(), member.getEmail(), member.getProfilePictureLink());
    }
    
    
}

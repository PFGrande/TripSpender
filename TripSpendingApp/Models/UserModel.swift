//
//  User.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation
import SwiftUI
import FirebaseAuth

// made user a class because it will be used all accross the app and accessing the instance
// is easier since it's not a value type.
// the struct is a value type, meaning that i will need to retrieve info from the server everytime i switch views

class User: Codable {
    var username: String;
    var email: String
    
    // if server allows, store pfps
    var profilePictureUrl: String;
    var UUID: String;
    
    
    
    init(username: String, profilePictureUrl: String) {
        self.username = username
        self.profilePictureUrl = profilePictureUrl
        if let currUser = Auth.auth().currentUser {
            if let email = currUser.email {
                self.email = email
            } else {
                self.email = ""
            }
            
            self.UUID = currUser.uid
        } else {
            self.email = ""
            self.UUID = ""
        }
        
        
//        getCurrUserInfo(self)
    }
    

//    private func getCurrUserInfo(user: User) -> Void {
//        if let currUser = Auth.auth().currentUser {
//            let email = currUser.email // User's email
//            let uid = currUser.uid // User's UID
//
//            // Display or use the email and UID as needed
//            print("Email: \(email ?? "No email available")")
//            print("UID: \(uid)")
//        } else {
//            print("No user is signed in.")
//        }
//    }
    
}

func fetchUserId() -> String {
    guard let currUser = Auth.auth().currentUser else {
        return ""
    }
    return currUser.uid
}
 

//
//  User.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

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

func sessiontStatus() -> FirebaseAuth.User? {
    print("SESSION STATUS:")
    print(Auth.auth().currentUser == nil)
    return Auth.auth().currentUser
}

func fetchUserRef(userId: String) -> DocumentReference {
    let db = Firestore.firestore()
    
    let userRef = db.collection("users").document(userId)
        
    return userRef
}

func getUserName(userId: String) async -> String? {
    var userRef = fetchUserRef(userId: userId)
    
    do {
        let userSnapshot = try await fetchUserRef(userId: userId).getDocument()
        
        if userSnapshot.exists {
            return userSnapshot["username"] as? String ?? "???"
        }
        
    } catch {
        return nil
    }
    return nil
}



//
//func fetchUserNameById(id: String) async -> String {
//
//    do {
//        var username: String = "" // if returns empty there was an error
//        do {
//            let db = Firestore.firestore()
//
//            let docRef = try await db.collection("users").whereField("filename", isEqualTo: id).getDocuments()
//
//            if docRef.documents.isEmpty{
//                return "unable to find user id"
//            } else {
//                for doc in docRef.documents {
//                    let dataDict = doc.data()
//                    username = dataDict["username"] as! String
//
//                }
//            }
//        }
//        return username
////        return "" // temp
//    } catch {
//        print("Error fetching user name: \(error.localizedDescription)")
//        return "err"
//    }
////    return "" // temp
//}
//

//
//  User.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation
import SwiftUI

// made user a class because it will be used all accross the app and accessing the instance
// is easier since it's not a value type.
// the struct is a value type, meaning that i will need to retrieve info from the server everytime i switch views

class User {
    var username: String;
    
    // if server allows, store pfps
    var profilePicture: Image;
    
    init(username: String, profilePicture: Image) {
           self.username = username
           self.profilePicture = profilePicture
       }
    
}

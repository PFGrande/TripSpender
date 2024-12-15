//
//  Trip.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation
//import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

// will contain information about the trip

struct TripInfo: Codable {
    var tripLeaderId: String; // id of trip owner
    
    var destination: String; // address provided by user
    var tripThumbnailUrl: String;
    var contributorIds: [String];
//    var tripItems: [TripItem];
    
    
    init(destination: String = "", tripThumbnailUrl: String = "", contributorIds: [String] = []) {
        if let currUser = Auth.auth().currentUser {
            self.tripLeaderId = currUser.uid
        } else {
            self.tripLeaderId = "nouser" // here is where I will call a different function for the user if they are in offline mode
        }
        
        self.destination = destination
        self.tripThumbnailUrl = tripThumbnailUrl
        self.contributorIds = contributorIds
        self.contributorIds[0] = self.tripLeaderId
        print("=====TripInfo Model initialized successfully=====")
    }
    
    
    // https://firebase.google.com/docs/firestore/manage-data/add-data#swift
    public func postTripInfo() {
        print("postTripInfo executing....")
        guard let currUser = Auth.auth().currentUser else {
            print("---user is not logged in---")
            return // here is where I will call a different function for the user if they are in offline mode
        }
        
//        FirebaseApp.configure() // caused app to crash due to it already being configured lol

        let db = Firestore.firestore()
        
        Task { // run asynchronously, if possible include something in the ui indicating upload progress
            print("task began executting...")
            do {
                print("do began excuting...")
                // not putting arg for document generates rng name
                // i can not name the item after its actual name, each document name must be unique
                try await db.collection("TripInfo").document().setData([
                    "tripLeaderId": currUser.uid,
                    "destination": self.destination,
                    "tripThumbnailUrl": self.tripThumbnailUrl,
                    "contributorIds": self.contributorIds // later write a function to add ppl after group creation, use append?
                ])
                print("TripInfo Document successfully written!")
            } catch {
                print("Error writing document: \(error)")
            }
            print("! ! ! task finished execution ! ! !")
        }
    }
    
//    func addContributor() {
//        add logic to append user to the list, happens at trip creation
//    }
    
//    func updateContributors() {
//        add logic for appending more users after the trip has already been created
//    }
    
    
    // write a function that just returns the contribuor id array's length to count members
}

//
//  TripItem.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

// will contain info on an item

struct TripItem: Codable {
    var name: String;
    var price: Double;
    var contributorsIds: [String]; // list of people opting in to contribute to an item added later on
    var canBeDeleted: Bool; // items added prior to the trip shall not be removed, only creator can remove it
    var addedById: String;
    // no more required items may be added to a trip after the list is created
    
    // https://firebase.google.com/docs/firestore/manage-data/add-data#swift
//    public func postTripItem(item: TripItem) {
//        FirebaseApp.configure()
//
//        let db = Firestore.firestore()
//        Task { // run asynchronously, if possible include something in the ui indicating upload progress
//            do {
//                // not putting arg for document generates rng name
//                // i can not name the item after its actual name, each document name must be unique
//                try await db.collection("TripItems").document().setData([
//                    "name": item.name,
//                    "state": "CA",
//                    "country": "USA"
//                ])
//                print("Document successfully written!")
//            } catch {
//                print("Error writing document: \(error)")
//            }
//        }
//    }
    
//    public func fetchTripItem() {
//
//    }
}

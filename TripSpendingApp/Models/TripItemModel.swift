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

struct TripItem: Codable, Identifiable {
    var id: String = "";
    var name: String = "";
    var price: Double = 0.00;
    var contributorsIds: [String] = []; // list of people opting in to contribute to an item added later on
    
    // can also be used to back if other users can opt out
    // items added prior to the trip shall not be removed, only creator can remove it
    var canBeDeleted: Bool = false;
    
    
    var addedById: String = "";
    var quantity: Int = 1;
    // no more required items may be added to a trip after the list is created
    
    
//    public func userOptIn(itemId: String) {
//        
//    }
//    
//    public func fetchItem(itemId: String) {
//        
//    }
//    
//    public func updateIem(itemId: String) {
//        
//    }
    
    // https://firebase.google.com/docs/firestore/manage-data/add-data#swift
    public func postTripItem(tripId: String) {

        let db = Firestore.firestore()
        
        Task { // run asynchronously, if possible include something in the ui indicating upload progress
            do {
                // not putting arg for document generates rng name
                // i can not name the item after its actual name, each document name must be unique
                
                let tripItemRef = db.collection("TripInfo")
                    .document(tripId)
                    .collection("TripItem")
                
                try await tripItemRef.addDocument(data: [
                    "name": self.name,
                    "price": self.price,     // Placeholder
                    "quantity": self.quantity,   // Placeholder
                    "addedById": self.addedById,
                    "canBeDeleted": self.canBeDeleted,
                    "contributorsIds": self.contributorsIds
                ])
                
                
                print("Item added to db")
            } catch {
                print("Error writing document: \(error)")
            }
        }
    }
    
}

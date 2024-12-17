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

struct TripInfo: Identifiable, Equatable, Hashable { // removing codeable may cause problems...
    var tripLeaderId: String; // id of trip owner
    let id: String;
    
    var destination: String; // address provided by user
    var tripThumbnailUrl: String;
    var contributorIds: [String];
//    var tripItems: [TripItem];
    
    var stringValue: String {
        return id
    }
    
    
    init(id: String, destination: String = "", tripThumbnailUrl: String = "", contributorIds: [String] = []) {
        if let currUser = Auth.auth().currentUser {
            self.tripLeaderId = currUser.uid
        } else {
            self.tripLeaderId = "nouser" // here is where I will call a different function for the user if they are in offline mode
        }
        self.id = id
        self.destination = destination
        self.tripThumbnailUrl = tripThumbnailUrl
        self.contributorIds = contributorIds
//        self.contributorIds[0] = self.tripLeaderId
        
        // was likely being added twice or replacing the added member because
        // an instance of the struct is created AFTER the user clicks submit
        // submission happens AFTER the user already added other members
        if !self.contributorIds.contains(self.tripLeaderId) {
            self.contributorIds.insert(self.tripLeaderId, at: 0) // replaced [0] with insert
        }
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
    
    // overrides operator (this is pretty cool reminds me of c++ :)
    static func == (lhs: TripInfo, rhs: TripInfo) -> Bool {
        return lhs.id == rhs.id
    }
    
    func fetchItems() async -> [TripItem] {
        var items: [TripItem] = []
        
        
        do {
            let db = Firestore.firestore()
            
            let tripsRef = try await db.collection("TripInfo").document(self.id).collection("TripItem").getDocuments()
            
            for doc in tripsRef.documents {
                let data = doc.data()
                var tripItem = TripItem()
                tripItem.id = doc.documentID
                print("fetchItems() doc id: \(tripItem.id)")
                tripItem.name = data["name"] as? String ?? "???"
                tripItem.price = data["price"] as? Double ?? 0.00
                tripItem.quantity = data["quanity"] as? Int ?? 1
                tripItem.addedById = data["addedById"] as? String ?? "???"
                tripItem.canBeDeleted = data["canBeDeleted"] as? Bool ?? false
                tripItem.contributorsIds = data["contributorsIds"] as? [String] ?? []
                
                items.append(tripItem)
            }
            
                
                
                
                
            } catch {
                print("error fetching items")
            }
        
        
        
        
        return items
    }
    
    // im thinking ! modularization
    
    // reminder: I am working on having users opt in and out
    // of paying for items on a trip
    
    public func userOptIn(itemId: String, newMemberId: String) async {
        let itemRef = await fetchItemRef(itemId: itemId)
        var tripItem: TripItem = await getItemFromRef(itemId: itemId, itemRef: itemRef)!
        tripItem.contributorsIds.append(newMemberId)
        
        updateItem(updatedItem: tripItem, itemRef: itemRef)
        
    }
    public func userOptOut(itemId: String, memberId: String) async {
        let itemRef = await fetchItemRef(itemId: itemId)
        var tripItem: TripItem = await getItemFromRef(itemId: itemId, itemRef: itemRef)!
        
        // remove old memberid
        if tripItem.contributorsIds.contains(memberId) {
            tripItem.contributorsIds.removeAll {
                $0 == memberId
            }
            
            updateItem(updatedItem: tripItem, itemRef: itemRef)
        }
        
    }
    
    public func getItemFromRef(itemId: String, itemRef: DocumentReference) async -> TripItem? {
        
        do {
            let itemSnapshot = try await fetchItemRef(itemId: itemId).getDocument()
            
            if itemSnapshot.exists {
                var tripItem = TripItem()
                let data = itemSnapshot
                
                tripItem.id = itemSnapshot.documentID
                print("fetchItems() doc id: \(tripItem.id)")
                tripItem.name = data["name"] as? String ?? "???"
                tripItem.price = data["price"] as? Double ?? 0.00
                tripItem.quantity = data["quanity"] as? Int ?? 1
                tripItem.addedById = data["addedById"] as? String ?? "???"
                tripItem.canBeDeleted = data["canBeDeleted"] as? Bool ?? false
                tripItem.contributorsIds = data["contributorsIds"] as? [String] ?? []
                
                return tripItem
            }
        }
        
        catch {
            print("error")
            return nil
        }
        return nil
        
    }
    
    public func fetchItemRef(itemId: String) async -> DocumentReference {
        
        let db = Firestore.firestore()
        
//        do {
            let itemRef = db.collection("TripInfo").document(self.id).collection("TripItem").document(itemId) //.getDocument()
            
            return itemRef
//            if itemRef.exists {
//                var tripItem = TripItem()
//                let data = itemRef
//
//                tripItem.id = itemRef.documentID
//                print("fetchItems() doc id: \(tripItem.id)")
//                tripItem.name = data["name"] as? String ?? "???"
//                tripItem.price = data["price"] as? Double ?? 0.00
//                tripItem.quantity = data["quanity"] as? Int ?? 1
//                tripItem.addedById = data["addedById"] as? String ?? "???"
//                tripItem.canBeDeleted = data["canBeDeleted"] as? Bool ?? false
//                tripItem.contributorsIds = data["contributorsIds"] as? [String] ?? []
//
//
//
//                return tripItem
//            }
//            return nil
//        } catch {
//            print("failed to fetch item")
//        }
//        return nil
        
    }
    
    
    // there is a firebase function to update items, look into it
    public func updateItem(updatedItem: TripItem, itemRef: DocumentReference) {
        itemRef.updateData([
            "contributorsIds": updatedItem.contributorsIds
        ])
        
    }
    
//    func addContributor() {
//        add logic to append user to the list, happens at trip creation
//    }
    
//    func updateContributors() {
//        add logic for appending more users after the trip has already been created
//    }
    
    
    // write a function that just returns the contribuor id array's length to count members
}

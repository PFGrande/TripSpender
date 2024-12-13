//
//  TripItem.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation

// will contain info on an item

struct TripItem {
    var name: String;
    var price: Int;
    var contributors: [User]; // list of people opting in to contribute to an item added later on
    var canBeDeleted: Bool; // items added prior to the trip shall not be removed, only creator can remove it
    // no more required items may be added to a trip after the list is created
    
}

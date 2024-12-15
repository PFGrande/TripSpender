//
//  DetailTripView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

// Will list all the items in a trip

import SwiftUI

struct DetailTripView: View {
    var trip: TripInfo
    
    var body: some View {
        VStack { // if i want a back button here, keep the Navigation stack
            // if not, replace it with a NavitationView
            // NavigationView will reset the navigation hierarchy
            Text("detail view test \(trip.destination)")
        }
        
    }
}

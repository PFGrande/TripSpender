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
//    var onNavigation: ((Route) -> Void)? = nil // Optional callback for navigation | suggested by chatgpt to fix navigation bug
    var onNavigation: (Route) -> Void
    
    var body: some View {
       VStack {
           Text("Destination: \(trip.destination)")
               .font(.largeTitle)
               .padding()

           Text("Trip Leader: \(trip.tripLeaderId)")
               .font(.title2)
               .padding()

           if !trip.contributorIds.isEmpty {
               Text("Contributors:")
                   .font(.headline)
                   .padding(.top)

               List(trip.contributorIds, id: \.self) { contributor in
                   Text(contributor)
               }
           } else {
               Text("No contributors yet.")
                   .foregroundColor(.gray)
                   .padding()
           }
       }
       .navigationTitle("Trip Details")
    }
}
// re-compute total price when optional cell is selected or decelected

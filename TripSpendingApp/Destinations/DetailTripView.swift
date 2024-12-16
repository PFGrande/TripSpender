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
    @State private var isShowingMembers = false
    
    // used chatgpt for temp visuals
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Thumbnail at the top
//                if let thumbnail: String = trip.tripThumbnailUrl {
                Text(trip.tripThumbnailUrl) // temporary until i learn to display img
//                        .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
//                } else {
//                    Rectangle()
//                        .fill(Color.gray.opacity(0.3))
//                        .frame(height: 200)
//                        .cornerRadius(10)
//                        .overlay(
//                            Text("No Image Available")
//                                .foregroundColor(.gray)
//                                .font(.caption)
//                        )
//                }

                // Destination text
                Text(trip.destination)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                // Button to show members
                Button(action: {
                    isShowingMembers = true
                }) {
                    Text("View Members")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingMembers) {
                    MemberListView(members: trip.contributorIds)
                }

                // List of TripItem instances implement when items are implemented
//                VStack(alignment: .leading, spacing: 10) {
//                    Text("Trip Items")
//                        .font(.headline)
//                        .padding(.top)
//
//                    List(trip.items) { item in
//                        HStack {
//                            Text(item.name)
//                                .font(.body)
//                            Spacer()
//                            Text(item.quantity)
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                    .frame(height: 200) // Adjust as needed
//                }
            }
            .padding()
        }
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
    }

}


// sheet to view users in trip
struct MemberListView: View {
    var members: [String] // Array of member names

    var body: some View {
        VStack {
            List(members, id: \.self) { member in
                Text(member)
            }
            .navigationTitle("Members")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    
    
    
}

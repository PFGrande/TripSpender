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
        VStack(alignment: .leading, spacing: 16) {
            Text("Trip Details")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 16)
            
            HStack {
                Text("Destination:")
                    .font(.headline)
                Spacer()
                Text(trip.destination)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            
            HStack {
                Text("Trip Leader:")
                    .font(.headline)
                Spacer()
                Text(trip.tripLeaderId)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Contributors:")
                    .font(.headline)
                if trip.contributorIds.isEmpty {
                    Text("No contributors")
                        .font(.body)
                        .foregroundColor(.gray)
                } else {
                    ForEach(trip.contributorIds, id: \.self) { contributor in
                        Text("- \(contributor)")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.vertical, 8)
            
            if !trip.tripThumbnailUrl.isEmpty {
                AsyncImage(url: URL(string: trip.tripThumbnailUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                } placeholder: {
                    ProgressView()
                }
                .padding(.top, 16)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Trip Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}



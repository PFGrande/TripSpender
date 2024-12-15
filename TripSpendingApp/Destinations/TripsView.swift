//
//  TripsView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import SwiftUI

struct TripsView: View {
//    @Binding
//    var path: [Route]
    @State
    var desiresCreation: Bool = false
    
    var body: some View {
            VStack {
                Text("navbar")
                    .font(.title)
                    .padding()
                Button(
                    action: {
//                        let testTrip = TripInfo()
//                        testTrip.postTripInfo()
                        desiresCreation = true
                        
                    }, label: {
                        Text("Temp test trip creation")
                    }
                )
                
            
//                NavigationLink(destination: CreateTripView()) {
//                    Text("Detail View")
//                        .font(.headline)
//                        .padding()
//                        .background(Color.orange)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
            }.navigationDestination(isPresented: $desiresCreation) {
                CreateTripView()
            }

    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}

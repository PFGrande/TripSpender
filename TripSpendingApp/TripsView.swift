//
//  TripsView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import SwiftUI

struct TripsView: View {
    var body: some View {
//        NavigationStack {
//            VStack {
//                Text("navbar")
//                    .font(.title)
//                    .padding()
//
//                NavigationLink(destination: CreateTripView()) {
//                    Text("Detail View")
//                        .font(.headline)
//                        .padding()
//                        .background(Color.orange)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//        }
//        .navigationTitle("Trips")
//        .toolbarBackground(Color.gray.opacity(0.9), for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//        .toolbarColorScheme(.dark, for: .navigationBar)
//        .navigationBarBackButtonHidden()
        NavigationView {
            VStack {
                Text("navbar")
                    .font(.title)
                    .padding()
            
                NavigationLink(destination: CreateTripView()) {
                    Text("Detail View")
                        .font(.headline)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .navigationBarBackButtonHidden(true) // im so dumb
    }
}

struct TripsView_Previews: PreviewProvider {
    static var previews: some View {
        TripsView()
    }
}

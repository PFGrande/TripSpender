//
//  ContentView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation
import SwiftUI
import FirebaseAuth


// code from lecture https://www.youtube.com/watch?v=g4HoFkd_I2Q&list=PLPNCkYpwTr1SKK8zrqRBJC71c4MO9yTIM&index=10
struct ContentView: View {
    
    @State
    var path: [Route] = []
//    @State
//    private var isLoggedIn: Bool = Auth.auth().currentUser != nil // take user directly to tripview if logged in
    // add this feature later, focus on sending and retrieving items
    
    var body: some View {
        NavigationStack(path: $path) { // THIS IS THE ON NAVIGATION FUNCTION WE PASS INTO HOMEVIEW
            
            HomeView { destination in
                path.append(destination)
            }.navigationDestination(for: Route.self) { route in
                switch route {
                case .tripsview:
                    TripsView().navigationBarBackButtonHidden()
                case .registrationview:
                    RegistrationView()
                case .loginview:
                    LoginView()
                case .tripinfomodel(let trip):
                    DetailTripView(trip: trip)
                }
            }
        }
    }
}

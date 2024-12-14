//
//  ContentView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import Foundation
import SwiftUI


// code from lecture https://www.youtube.com/watch?v=g4HoFkd_I2Q&list=PLPNCkYpwTr1SKK8zrqRBJC71c4MO9yTIM&index=10
struct ContentView: View {
    
    @State
    var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) { // THIS IS THE ON NAVIGATION FUNCTION WE PASS INTO HOMEVIEW
            HomeView { destination in
                path.append(destination)
            }.navigationDestination(for: Route.self) { route in
                switch route {
                case .tripsview:
                    TripsView()
                case .registrationview:
                    RegistrationView()
                case .loginview:
                    LoginView()
                }
            }
        }
    }
}

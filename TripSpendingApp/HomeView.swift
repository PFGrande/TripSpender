//
//  ContentView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/12/24.
//

// features ideas:
// add feature using map to estimate the gas price for the trip

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.accentColor)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Log in")
                            .padding()
                            .frame(width: 300, height: 80)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                    
                    // register acc
                    NavigationLink(destination: RegistrationView()) {
                        Text("Register")
                            .padding()
                            .frame(width: 300, height: 80)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                    
                    // no login needed
                    NavigationLink(destination: TripsView()) {
                        Text("Offline Mode")
                            .padding()
                            .frame(width: 300, height: 80)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                     
                    
                }
                
                HStack {
                    Image("spendee")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Image("spender")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: 200)
            
        }
        
            
            
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

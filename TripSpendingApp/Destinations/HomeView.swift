//
//  ContentView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/12/24.
//

// features ideas:
// add feature using map to estimate the gas price for the trip

// navigation overhaul references: https://www.youtube.com/watch?v=g4HoFkd_I2Q&list=PLPNCkYpwTr1SKK8zrqRBJC71c4MO9yTIM&index=10
// the lecture covers how NagivationStacks and NavigationPaths are used instead of navigation links
// professor mentioned distaste for the navigation links, and i have realized after multple attempts to remove the
// back button, that I don't really know what the navigation stack is doing when I use navigation views.
// navigation paths should be more straightforward.

import Foundation

import SwiftUI
import FirebaseAuth

// code from lecture https://www.youtube.com/watch?v=g4HoFkd_I2Q&list=PLPNCkYpwTr1SKK8zrqRBJC71c4MO9yTIM&index=10
struct HomeView: View {
    
    var onNavigation: (Route) -> Void
    
    @State
    var loginStatus: Bool = sessiontStatus() != nil
    
    var body: some View {
        VStack {
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.accentColor)

                Button(action: {
                    onNavigation(.loginview)
                }, label: {
                    renderHomeMenuButtonText(color: Color.blue, text: "Log in")
                })

                // register acc
                Button(action: {
                    onNavigation(.registrationview)
                    
                }, label: {
                    renderHomeMenuButtonText(color: Color.orange, text: "Register")
                })

                // no login needed
                if (loginStatus) {
                    Button(action: {
                        onNavigation(.tripsview)
                    }, label: {
                        renderHomeMenuButtonText(color: Color.red, text: "Proceed to Trips")
                    })
                    
                    Button(action: {
                        logOut()
                        loginStatus = sessiontStatus() != nil
                    }, label: {
                        Text("log out")
                    }
                    )
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
}

func renderHomeMenuButtonText(color: Color, text: String) -> some View {
    Text(text)
        .padding()
        .frame(width: 300, height: 80)
        .background(color)
        .foregroundColor(.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 5, x: 0, y: 5)
}

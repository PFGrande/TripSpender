//
//  ContentView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/12/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Button(
                action: {
                    // did tap
                },
                label: { Text("Log in") }
            )
            Button(
                action: {
                    // did tap
                },
                label: { Text("Register") }
            )
            Button(
                action: {
                    // did tap
                },
                label: { Text("Offline Mode") }
            )
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

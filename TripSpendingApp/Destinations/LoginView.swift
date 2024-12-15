//
//  LoginView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//
import SwiftUI
import FirebaseAuth

// began using NavigationStacks, will overhaul navigation system

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .frame(width: 200)
                .fontWeight(.bold)
                .foregroundColor(Color.green)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                login(email: email, password: password) { error in
                    if let error = error {
                        errorMessage = error.localizedDescription
                    } else {
                        isLoggedIn = true
                    }
                }
            }) {
                Text("Log In")
                    .font(.headline)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding()
            }

            Spacer()
        }
            .padding()
            .navigationDestination(isPresented: $isLoggedIn) {
                TripsView().navigationBarBackButtonHidden()
            }
        
    }
}


// https://firebase.google.com/docs/auth/ios/password-auth & chatgpt
func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
        completion(error)
    }
}



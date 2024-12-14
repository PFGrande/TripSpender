//
//  RegistrationView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct RegistrationView: View {
    @State
    private var username = ""
    @State
    private var email = ""
    @State
    private var password = ""
    @State
    private var confirmPass = ""
    @State
    private var errorMessage = ""
    
    var body: some View {
        VStack {
            Text("Register Account")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .frame(width: 200)
                .foregroundColor(Color.green)
//                .foregroundStyle(.blue.gradient) didn't do anything :(
//                .padding()
                .padding(.bottom, 50)
            
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $confirmPass)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(
                action: {
                    if password == confirmPass {
                        register(email: email, password: password, username: username) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                            }
                            else {
                                errorMessage = "Registration successful!"
                            }
                        }
                    } else {
                        errorMessage = "passwords must match"
                    }
                },
                label: {
                    Text("Register")
                        
                })
                    .font(.headline)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 40)
            
            // generated using chatgpt
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(errorMessage.contains("successful") ? .green : .red)
                    .padding()
            }
        }
        .padding()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}

// generated using chatGPT
func register(email: String, password: String, username: String, completion: @escaping (Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
        if let error = error {
            completion(error)
        } else if let user = authResult?.user {
            let db = Firestore.firestore()
            db.collection("users").document(user.uid).setData([
                "username": username,
                "email": email
            ]) { firestoreError in
                completion(firestoreError)
            }
        }
    }
}

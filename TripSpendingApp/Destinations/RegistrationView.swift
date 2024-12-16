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
    @State
    private var isRegistered: Bool = false
    @State
    private var isAvailable: Bool = false // won't allow an empty name
    
    var body: some View {
        VStack {
            Text("Register Account")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(width: 200)
                .foregroundColor(Color.green)
            //                .foregroundStyle(.blue.gradient) didn't do anything :(
            //                .padding()
                .padding(.bottom, 50)
            
            TextField("Username", text: $username)
                .onChange(of: username) { newValue in
                checkNameAvailability()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Confirm Password", text: $confirmPass)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            
            
            Button(
                action: {
                    if password == confirmPass && isAvailable {
                        register(email: email, password: password, username: username) { error in
                            if let error = error {
                                errorMessage = error.localizedDescription
                            }
                            else {
                                errorMessage = "Registration successful!"
//                                isRegistered = true
                            }
                        }
                    } else if password != confirmPass {
                        errorMessage = "passwords must match"
                    } else if !isAvailable {
                        errorMessage = "user name taken"
                    }
                },
                label: {
                    Text("Register")
                    
                })
            .font(.headline)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.top, 30)
            .padding(.horizontal)
            
            // generated using chatgpt
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(errorMessage.contains("successful") ? .green : .red)
                    .padding()
                
            }
            
            
            
//             soon to be deprecated constructor...
//             code referenced:
//             https://stackoverflow.com/questions/65244680/how-to-make-a-swiftui-navigationlink-conditional-based-on-an-optional-object
//                NavigationLink(destination: TripsView().navigationBarBackButtonHidden(true), isActive: $isRegistered) {
//                    EmptyView()
//                }
         
        }
            .padding()
            .navigationDestination(isPresented: $isRegistered) {
                TripsView().navigationBarBackButtonHidden()
            }
            
        
//        .navigationBarBackButtonHidden(true)
//        .navigationBarBackButtonHidden(!isRegistered)
        
    }
    
    func checkNameAvailability() {
        print("Username: \(username)")
        print("isAvailable: \(isAvailable)")
        print("isRegistered: \(isRegistered)")
        print("passwords match:  \(password == confirmPass)")

        Task {
            do {
                let db = Firestore.firestore()
                
                let docRef = try await db.collection("users").whereField("username", isEqualTo: username).getDocuments()
                if docRef.isEmpty {
                    isAvailable = true
                    return
                } else {
                    errorMessage = "name is already taken"
                    isAvailable = false
                    return
                }
                
            } catch {
                isAvailable = false
                errorMessage = "name is already taken"
                return
            }
        }
    }
    
    // generated using chatGPT
    func register(email: String, password: String, username: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
            } else if let user = authResult?.user {
                let db = Firestore.firestore()
                db.collection("users").document(user.uid).setData([ // document created named after userid for easier queries
                    "username": username,
                    "email": email,
                ]) { firestoreError in
                    completion(firestoreError)
                }
            }
        }
        isRegistered = true
    }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}






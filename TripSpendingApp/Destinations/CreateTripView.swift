//
//  CreateTripView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

// will list all the trips the user is a part of

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct CreateTripView: View {
    @State
    private var destination: String = ""
    @State
    private var tripThumbnailUrl: String = ""
    @State
    private var tripCreated = false
    @State
    private var contributorIds: [String] = []
    @State
    private var newContributorUsername: String = ""
    @State
    private var errorMessage: String = ""
    @State
    private var successMessage: String = ""
    @State
    private var submittedTrip: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create New Trip")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .frame(width: 300)
                .fontWeight(.bold)
                .foregroundColor(Color.green)

            TextField("Destination", text: $destination)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Thumbnail URL", text: $tripThumbnailUrl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            TextField("Add Contributor by Username", text: $newContributorUsername, onCommit: {
                addContributorByUsername()
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("add user") {
                addContributorByUsername()
            }
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding()
            }

            Button("Create Trip") {
//                destination: String = "", tripThumbnailUrl: String = "", contributorIds: [String] = []
                if (!destination.isEmpty && !tripThumbnailUrl.isEmpty) {
                    let newTrip = TripInfo(destination: destination, tripThumbnailUrl: tripThumbnailUrl, contributorIds: contributorIds)
                    newTrip.postTripInfo()
                    submittedTrip = true
                } else {
                    errorMessage = "Please provide a trip name and destination"
                }
                
            }
            .font(.headline)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Spacer()
        }.navigationDestination(isPresented: $submittedTrip) {
            TripsView().navigationBarBackButtonHidden()
        }
    }
    
    
    
    // referenced https://firebase.google.com/docs/firestore/query-data/get-data#swift_3
    private func addContributorByUsername() {
        guard !newContributorUsername.isEmpty else {
            errorMessage = "Username cannot be empty"
            return
        }
        Task {
            var docId: String = ""
            do {
                let db = Firestore.firestore()
                let docRef = try await db.collection("users").whereField("username", isEqualTo: newContributorUsername).getDocuments()
                
                if docRef.documents.isEmpty {
                    errorMessage = "No user with that name"
                    return
                } else {
                    for doc in docRef.documents { // iterate through the query collection
                        docId = doc.documentID
                        print("---docId: \(docId)---")
                    }
                }
            } catch {
                errorMessage = "No user found with that name" // might not be shown to user since this is async
                print("error in the do statement")
                return
            }
            
            // moving this iside the task stops the code from adding users that do not exist in the db
            if (!contributorIds.contains(docId)) {
                contributorIds.append(docId)
                print("APPENDED \(docId)")
            } else {
                errorMessage = "user has already been added"
            }
            
            
            
            
            newContributorUsername = ""
        }
        
    }

}

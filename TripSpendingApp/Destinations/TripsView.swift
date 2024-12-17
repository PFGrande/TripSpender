//
//  TripsView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//


// Note: REMEMBER TO ADD FUNCTIONALITY TO VIEW LISTS YOU've BEEN INVITED TO
// Note: REMEMBER TO POSSIBLY PUSH THE PLIST
// if there is time, add an invite system, realistically users shouldnt be auto invited to something that
// will cost them money...

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct TripsView: View {
//    @Binding
//    var path: [Route]
    @State
    var desiresCreation: Bool = false
    @State
    var tripsList: [TripInfo] = []
    @State
    var errorMessage: String = ""
    @State
    var loggedOut = false
    
    var body: some View {
            VStack {
                Button(
                    
                    action: {
                        logOut()
                        loggedOut = true
                        
                    },
                        
                    label: {
                        Text("logout")
                    }
                
                
                )
                Text("Your Trips")
                    .font(.title)
                    .padding()
                Button(
                    action: {
//                        let testTrip = TripInfo()
//                        testTrip.postTripInfo()
                        desiresCreation = true
                        
                    }, label: {
//                        Text("Temp test trip creation")
                        Text("add a new trip")
                    }
                )
                
//                if tripsList.isEmpty {
//                    if !errorMessage.isEmpty {
//                        Text(errorMessage)
//                            .foregroundColor(.red)
//                    } else {
//                        Text("Loading trips...")
//                            .foregroundColor(.gray)
//                    }
//                } else {
//                    renderUserTrips()
//                }
                
                
                
                
                renderUserTrips()
                
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                }
            
//                NavigationLink(destination: CreateTripView()) {
//                    Text("Detail View")
//                        .font(.headline)
//                        .padding()
//                        .background(Color.orange)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
            }.navigationDestination(isPresented: $desiresCreation) {
                CreateTripView()
            }.onAppear() {
                loggedOut = sessiontStatus() == nil
                fetchUserTrips()
            }
            .refreshable {
                fetchUserTrips()
            }.navigationDestination(isPresented: $loggedOut) {
                LoginView().navigationBarBackButtonHidden()
            }

    }
    
    func addToList(docRef: QuerySnapshot) -> Void{
        // referenced https://firebase.google.com/docs/firestore/query-data/get-data#swift_3
        for doc in docRef.documents { // iterate through the query collection
//                        print("---docId: \(doc.documentID)---")
//                        print("DATA: ")
//                        print(doc.data())
            if !doc.data().isEmpty { // probably redundant check
                var tripElement = TripInfo(id: doc.documentID) // instance to upload
                let dataDict = doc.data()
                
                tripElement.destination = dataDict["destination"] as? String ?? "Unknown Destination"
                tripElement.tripLeaderId = dataDict["tripLeaderId"] as? String ?? "Unknown Leader"
                tripElement.tripThumbnailUrl = dataDict["tripThumbnailUrl"] as? String ?? ""
                tripElement.contributorIds = dataDict["contributorIds"] as? [String] ?? []
                
//                            print("TRIP ELEMENT: ")
//                            print("trip: \(tripElement)")
                
//                            fetchedTrips.append(tripElement)
                if (!tripsList.contains(tripElement)) {
                    tripsList.append(tripElement)
                } else {
                    print("trips already in the tripsList")
                }
                
            }
            
            
            
//                        doc.data(as: <#T##Decodable.Protocol#>) find out how to use this might look nicer...
//                        tripsList.append()
        }
    }
    
    func fetchUserTrips() {
//        print("===-FETCHING TRIPS-===")
        Task {
            do {
                let userId: String = fetchUserId()
                if userId == "" {
                    print("user not found")
                    return
                }
                
                let db = Firestore.firestore()
                
                // I also need to add a way to fetch the trips they've been added to
                let docRef = try await db.collection("TripInfo").whereField("tripLeaderId", isEqualTo: userId).getDocuments()
                let memberDocRef = try await db.collection("TripInfo").whereField("contributorIds", arrayContains: userId).getDocuments()
                
                if docRef.documents.isEmpty {
                    errorMessage = "you have no trips"
                    return
                } else {
                    addToList(docRef: docRef)
                }
                if memberDocRef.documents.isEmpty {
                    return
                } else {
                    addToList(docRef: memberDocRef)
                }
                
            } catch {
                errorMessage = "Query Error: Unable to fetch user trips" // might not be shown to user since this is async
                print("error in the do statement")
                return
            }
            
        }
        
        
        
    }
    
    
    // https://developer.apple.com/documentation/swiftui/list
    func renderUserTrips() -> some View {
        List(tripsList) { trip in
            NavigationLink(
                destination: DetailTripView(trip: trip), // Navigate to a view specific to this trip
                label: {
                    VStack {
                        Text(trip.destination)
                            .font(.headline)
                        
                        Text("Leader: \(trip.tripLeaderId)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            )
        }
        .refreshable {
            fetchUserTrips() // Reload trips when the user pulls to refresh
        }
        
        
//        .refreshable {
//            fetchUserTrips() // Reload trips when the user pulls to refresh
//        }
//        .navigationTitle("Your Trips")
    }
    
}

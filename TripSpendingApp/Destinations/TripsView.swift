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
// BUG: offline mode shows ALL trips...

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct TripsView: View {
//    @Binding
//    var path: [Route]
    @State
    var desiresCreation: Bool = false
    @State
    var tripsList: [TripInfo] = []
    @State
    var errorMessage: String = ""
//    @State
//    var selectedTrip: TripInfo = TripInfo(id: "")
    
    
    var body: some View {
        VStack {
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
//            ForEach(tripsList) { trip in
//                DetailTripView(trip: trip)
//            }
        }.onAppear() {
            fetchUserTrips()
        }
        .refreshable {
            fetchUserTrips()
        }

    }
    
    func addToList(docRef: QuerySnapshot) -> Void{
        // referenced https://firebase.google.com/docs/firestore/query-data/get-data#swift_3
        for doc in docRef.documents { // iterate through the query collection
//                        print("---docId: \(doc.documentID)---")
//                        print("DATA: ")
//                        print(doc.data())
            if !doc.data().isEmpty { // probably redundant check
                var tripElement = TripInfo(id: doc.documentID)
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
//        print("--- RENDERING TRIPS: ---")
//        print("PRINTING LIST")
//        print(tripsList)
        return List(tripsList) { trip in
            VStack(alignment: .leading) {
                Text(trip.destination)
                    .font(.headline)
                Text("Leader: \(trip.tripLeaderId)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
//        .refreshable {
//            fetchUserTrips() // Reload trips when the user pulls to refresh
//        }
//        .navigationTitle("Your Trips")
    }
    
}



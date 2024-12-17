//
//  DetailTripView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

// Will list all the items in a trip

import SwiftUI
import FirebaseFirestore

struct DetailTripView: View {
    var trip: TripInfo
    @State
    private var isShowingMembers = false
    @State
    private var isAddingItem = false
    @State
    private var items: [TripItem] = []
    @State
    private var itemFetchTask: Task<Void, Never>? // suggested by chatgpt
    
    // used chatgpt for temp visuals
    var body: some View {
        //ScrollView {
        VStack(spacing: 20) {
            // Thumbnail at the top
//                if let thumbnail: String = trip.tripThumbnailUrl {
            Text(trip.tripThumbnailUrl) // temporary until i learn to display img
//                        .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(10)
//                } else {
//                    Rectangle()
//                        .fill(Color.gray.opacity(0.3))
//                        .frame(height: 200)
//                        .cornerRadius(10)
//                        .overlay(
//                            Text("No Image Available")
//                                .foregroundColor(.gray)
//                                .font(.caption)
//                        )
//                }

            // Destination text
            Text(trip.destination)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            // Button to show item adding menu
            Button(action: {
                isAddingItem = true
                
            }) {
                Text("Add Item")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isAddingItem) {
                AddItemView(tripId: trip.id, isPresented: $isAddingItem)
            } // after an item is added the list does NOT
            // auto-refresh...
            
            // Button to show members
            Button(action: {
                isShowingMembers = true
            }) {
                Text("View Members")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .sheet(isPresented: $isShowingMembers) {
                MemberListView(members: trip.contributorIds)
            }
            
            renderItems()
//            List(items) { item in
//                Text(item.name)
//
//            }.onAppear() {
//                itemFetchTask = Task {
//                    print("ON APPEAR:::::")
//                    print(items)
//                    items = await trip.fetchItems()
//                    print("AFTER")
//                    print(items)
//                }
//            }.onDisappear() {
//                // suggested by chatgpt
//                // apparently when the task is called it doesnt stop when the view is no longer being rendered
//                // might have caused a memory leak somewhere
//                // without knowing earlier into the project
//                itemFetchTask?.cancel()
//            }.refreshable {
//                itemFetchTask = Task {
//                    items = await trip.fetchItems()
//                }
//            }
//                renderItems()

        }
        .padding()
        //}
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
//    func renderItems() {
//        trip.fetchItems()
//    }
    
    func renderItems() -> some View {
        
        // added binding
        List(items) { item in
            
//            var itemText = Text(item.name)
            Text(item.name)
                .foregroundColor(item.canBeDeleted ? .blue : .red)
                .listRowBackground(item.contributorsIds.contains(fetchUserId()) ? Color.white : Color.gray)
                .onLongPressGesture {
                    print("long pressed")
                    // here display if a user can remove an item from the lsit.
                    // to delete an item the user must be the owner of the trip or the item
                }
                .contextMenu {
                    if (item.addedById == fetchUserId()) {
                        Button(action: {
                            print("delete \(item.name)")
                        }) {
                            Label("delete", systemImage: "trash.square.fill")
                        }
                    }
                    
                    if (item.contributorsIds.contains(fetchUserId())) {
                        Button(action: {
                            print("opt-out \(item.name)")
                        }) {
                            Label("opt-out", systemImage: "person.fill.badge.minus")
                        }
                    } else {
                        Button(action: {
                            Task {
                                await trip.userOptIn(itemId: item.id, newMemberId: fetchUserId())
                            }
                            print("opt-in \(item.name)")
                        }) {
                            Label("opt-in", systemImage: "person.fill.badge.plus")
                        }
                    }
                    
                }
            
            
//            if (item.canBeDeleted) {
//
//
//
//
//            }
            
            
            
            
//            if (item.contributorsIds.contains(fetchUserId())) {
//                Text(item.name).listRowBackground(.gray)
//            } else {
//                Text(item.name).listRowBackground(.white)
//            }
                

        }.onAppear() {
            itemFetchTask = Task {
                print("ON APPEAR:::::")
                print(items)
                items = await trip.fetchItems()
                print("AFTER")
                print(items)
            }
        }.onDisappear() {
            // suggested by chatgpt
            // apparently when the task is called it doesnt stop when the view is no longer being rendered
            // might have caused a memory leak somewhere
            // without knowing earlier into the project
            itemFetchTask?.cancel()
        }.refreshable {
            itemFetchTask = Task {
                items = await trip.fetchItems()
            }
        }

    }

}


// sheet to view users in trip
struct MemberListView: View {
    var members: [String] // Array of member ids
    
    @State
    private var memberNames: [String] = []// array of member names
    
    var body: some View {
        VStack {
            List(memberNames, id: \.self) { member in
                Text(member)
            }
            .navigationTitle("Members")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear() {
                fetchMemberUsernames()
            }
        }
    }

    // im going to be honest, a function like this should be in the user model
    // but this is quicker to implement. I will most likely have to refactor the code
    // since i dont like this approach
    func fetchMemberUsernames() {
        Task {
            do {
                let db = Firestore.firestore()
                for member in members {
                    let docRef = try await db.collection("users").document(member).getDocument()
                    if docRef.exists {
                        let username = docRef["username"] as? String ?? ""
//                        print(username)
                        memberNames.append(username)
                    } else { return }
                }
                
            } catch {
                print("err fetching names: query err")
                return
            }
        }
    }
    
    
    
}

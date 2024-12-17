//
//  AddItemView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

// will be a sheet that slides up in the detail trip view

import SwiftUI


struct AddItemView: View {
    var trip: TripInfo
    
//    var tripId: String
    @State
    var itemSubmitted: Bool = false
    @State
    var itemName: String = ""
    @State
    var itemPriceString: String = ""
    @State
    var itemPrice: Double = 0
    @State
    var errorMessage: String = ""
    @Binding
    var isPresented: Bool
    @State
    var isRequiredItem: Bool = false
    
    var body: some View {
        VStack {
            Text("Add Item")
                .font(Font.system(size: 35))
                .padding(.bottom, 45)
                .bold()
            // formatting for price field
            HStack {
                Text("$")
                    .font(Font.system(size: 100))
                Spacer(minLength: 3)
                TextField("0", text: $itemPriceString)
                    .keyboardType(.decimalPad)
                    .onChange(of: itemPriceString) { newValue in
                        
                        
                        // make it so that . is always 2 spaces away from the end
                        if (newValue.count > 3) {
//                                var endingIndex = newValue.index(newValue.endIndex, offsetBy: -2)
                            if let periodIndex = itemPriceString.firstIndex(of: ".") {
                                itemPriceString.remove(at: periodIndex)
                            }
                            
                            let endingIndex = newValue.index(newValue.endIndex, offsetBy: -3)
                            itemPriceString.insert(".", at: endingIndex)
                            
                        }
                        

                    }
                    .font(Font.system(size: 70))
                    .fontWeight(.heavy)
                    .textFieldStyle(.roundedBorder)
//                    .frame(height: 50)
                    .padding(.top, 12)
//                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
//                    .frame(minHeight: 100)
//                    .underline()
            }
            
            
            
            
            HStack {
                TextField("Item Name", text: $itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 10)
                    .font(Font.system(size: 30))
                    .frame(width: 170)
                    .padding(.bottom, 30)

            }
            
            if (fetchUserId() == trip.tripLeaderId) {
                HStack {
                    Toggle("Is this an required item?", isOn: $isRequiredItem)
                }
            }
            
            
            Button(
                action: {
                    if let price = Double(itemPriceString) {
                        itemPrice = price
                    } else {
                        itemPrice = 0
                    }
                    //                UnitTemperature cool info
                    if itemName.isEmpty || itemPrice <= 0 {
                        errorMessage = "Please provide a valid item name and price."
                   } else {
                       isPresented = false
                       var newItem = TripItem()
                       let userId = fetchUserId()
                       
                       newItem.name = itemName
                       newItem.price = itemPrice
                       newItem.canBeDeleted = !isRequiredItem
                       newItem.addedById = userId
                       newItem.contributorsIds.append(userId)
                       
                       if (!newItem.canBeDeleted) {
                           for member in trip.contributorIds.dropFirst() {
                               newItem.contributorsIds.append(member)
                           }
                       }
                       
                       newItem.postTripItem(tripId: trip.id)
                       
                       // Handle the item addition logic
                       print("Item added: \(itemName) - $\(itemPrice)")
                       
                       // Dismiss the sheet
                   }
                    
                    
                },
                label: {
                    Text("Add Item")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.bottom, 10)
            }
        }
    }
}



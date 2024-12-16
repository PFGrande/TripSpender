//
//  AddItemView.swift
//  TripSpendingApp
//
//  Created by Pedro F. Grande on 12/13/24.
//

// will be a sheet that slides up in the detail trip view

import SwiftUI


struct AddItemView: View {
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
    
    var body: some View {
        VStack {
            HStack {
                TextField("Item Name", text: $itemName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // formatting for price field
                HStack {
                    Text("$")
                    TextField("Price", text: $itemPriceString)
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
                        .textFieldStyle(RoundedBorderTextFieldStyle())
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
                }
                
            )
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.bottom, 10)
            }
        }
    }
}



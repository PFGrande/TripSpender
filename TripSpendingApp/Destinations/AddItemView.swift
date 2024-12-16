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
                HStack {
                    Text("$")
                    TextField("Price", text: $itemPriceString)
                        .keyboardType(.decimalPad)
                        .onChange(of: itemPriceString) { newValue in
                            
                            
                            
                            if (newValue.count > 3) {
//                                var endingIndex = newValue.index(newValue.endIndex, offsetBy: -2)
                                if let periodIndex = itemPriceString.firstIndex(of: ".") {
                                    itemPriceString.remove(at: periodIndex)
                                }
                                
                                let endingIndex = newValue.index(newValue.endIndex, offsetBy: -3)
                                itemPriceString.insert(".", at: endingIndex)
                                
                                
//                                if (!newValue.contains(".")){
//                                    let endingIndex = newValue.index(newValue.endIndex, offsetBy: -2)
//                                    itemPriceString.insert(".", at: endingIndex)
                                    
//                                }
                                
//                                if (newValue.contains(".") && newValue.count > 4) {
////                                    itemPriceString = String(newValue.reversed())
//                                    var endingIndex = newValue.index(ofAccessibilityElement: newValue.firstIndex(of: "."))
//                                    itemPriceString.remove(at: endingIndex)
//                                }
                                
                                
                                
                                
                                
                            }
                            
                            
//                            if (itemPriceString.count >= 4) {
//                                let removeIndex = itemPriceString.index(after: itemPriceString.endIndex, offsetBy: 4, limitedBy: itemPriceString.endIndex)
//                                itemPriceString.remove(at: removeIndex)
//
//                                let insertIndex = itemPriceString.index(after: itemPriceString.endIndex, offsetBy: 3, limitedBy: itemPriceString.endIndex)
//                                itemPriceString.insert(".", at: insertIndex)
//                            }
                            
                            
                            // guarantee here (using the string) that the double will not
                            // exceed to decimal places
                            
                            

                            
//                            print("NEWVALUE VALUE::::")
//                            print(newValue)
//
//
//                            if let price = Double(newValue) {// Convert the string to a Double
//                                if (price != 0) {
//                                    itemPrice = (price * 100).rounded() / 100
//                                    itemPriceString = formatPrice(itemPrice)
//                                }
//
//
//                            } else {
//                                errorMessage = "invalid price, please try again"
//                                itemPrice = 0
//
//                            }
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            
            Button(
                action: {
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


